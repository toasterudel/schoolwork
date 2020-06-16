# Christopher Rudel
# Professor Dugas
# CS 581WS
# Assignment05
# epinionParser.py
#
#
# To run this file, simply run 
# python3 epinionParser.py
# The program will ask you to Input the filename,
# ensure the file is in the same directory
# so that you can simply put in the file name 
#
#
# The goal of this script is to parse the epinion tree that are listed in the files:
# epinions96.csv, epinions_small.csv, epinions.csv
# and perform data analysis on the results from the parsing
#
# NOTE: epinions_small.csv takes around 3 minutes to run, i do not expect that epinions.csv will run
#

import networkx as nx  # recommended by assignment

print("Input the filename: ")
input_file = input()
graph = nx.Graph()
selfLoops = 0
posTrusts = 0
negTrusts = 0
edges = 0
# originally i used graph.edges() for edges but it wasn't giving me the count i wanted
# likely because it doesn't count self-loops
with open(input_file, "r") as fial:  # file is a reserved keyword
    for line in fial:
        one, two, three = line.split(",")
        u, v, weight = int(one), int(two), int(three)
        if(u == v):  # self loop
            selfLoops += 1
        elif(weight == 1):  # positive trust
            posTrusts += 1
        elif(weight == -1):  # distrust
            negTrusts += 1
        graph.add_edge(u, v, weight=weight)
        edges += 1

# weights has edge data (u,v) and the edge weight
weights = nx.get_edge_attributes(graph, 'weight')

triangles = []
# below is a time killer, takes a long time to identify all triangles
# but when i tried implementing it on my own it wouldnt finish
for x in nx.enumerate_all_cliques(graph):  # finds all triads in the graph
    if (len(x) == 3):
        triangles.append(x)

# calculating probability there is a trusted edge and a distrusted edge
trustProb = posTrusts / (edges-selfLoops)
dtrustProb = 1-trustProb

TTT = []  # weight should be 1+1+1
TTD = []  # should be 1
TDD = []  # should be -1
DDD = []  # should be -3

for x, y, z in triangles:
    # i check for either because one could be 'None'
    # which is when the direction is wrong (a->b when it shouldve been b->a)
    weight1 = weights.get((x, y)) or weights.get((y, x))
    weight2 = weights.get((y, z)) or weights.get((z, y))
    weight3 = weights.get((x, z)) or weights.get((z, x))
    sum = weight1+weight2+weight3
    if(sum == 3):
        TTT.append([x, y, z])
    elif(sum == 1):
        TTD.append([x, y, z])
    elif(sum == -1):
        TDD.append([x, y, z])
    else:
        DDD.append([x, y, z])
# total triads, should be triangles
sum = len(TTT) + len(TTD) + len(TDD) + len(DDD)

# if the different number of triads ≠ number of triangles, throw an error
assert sum == len(triangles), "Triads were miscounted"

####           PRINTING                    ####

print("Edges in network:", edges)
print("Self-loops:", selfLoops)
print("Edges used (TotEdges):", edges - selfLoops)
print("Trust edges:", posTrusts, "\tProbablity p:", trustProb)
print("Distrust edges:", negTrusts, "\tProbablity p:", dtrustProb)
print("Total Triangles:", len(triangles))

print("Expected Distribution\t\t\tActual Distribution")
print("Type\tpercent \tnumber\t\tType\tpercent \tnumber")
print("TTT\t%f\t%f\tTTT\t%f\t%d" % ((trustProb**3),
                                    ((trustProb**3) * (len(triangles))), (len(TTT) / sum), len(TTT)))
print("TTD\t%f\t%f\tTTD\t%f\t%d" % ((3*trustProb*trustProb*dtrustProb),
                                    ((3*trustProb*trustProb*dtrustProb) * (len(triangles))), (len(TTD) / sum), len(TTD)))
print("TDD\t%f\t%f\tTDD\t%f\t%d" % ((3*trustProb*dtrustProb*dtrustProb),
                                    ((3*trustProb*dtrustProb*dtrustProb) * (len(triangles))), (len(TDD) / sum), len(TDD)))
print("DDD\t%f\t%f\tDDD\t%f\t%d" % ((dtrustProb**3),
                                    ((dtrustProb**3) * (len(triangles))), (len(DDD) / sum), len(DDD)))
