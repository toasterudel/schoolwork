const papa = require("papaparse");
const fs = require("fs");
const file = fs.createReadStream("epinions96.csv");
const jsnx = require("jsnetworkx");
const Graph = require("graph-data-structure");
let gdsGraph = Graph();
let graph = new jsnx.Graph();
let myResults = [];
let resultsNoSelfLoop = [];
let interviewer = [];
let interviewee = [];
let trusts = [];
let analyzedData = {
  edges: 0, //count
  selfLoops: 0,
  totEdges: 0,
  posTrust: 0, //positive trusts
  negTrust: 0, //distrust
  probPositive: 0.0,
  probNegative: 0.0
};

async function parse() {
  papa.parse(file, {
    worker: false, //speeds up process
    step: results => {
      if (results.data[0] == results.data[1]) {
        // self loop
        analyzedData.edges++;
        analyzedData.selfLoops++;
      } else {
        analyzedData.edges++;
        if (results.data[2] == 1) {
          //positive trust
          analyzedData.posTrust++;
        } else {
          //distrust
          analyzedData.negTrust++;
        }
        resultsNoSelfLoop.push(results.data);
        graph.addEdge(results.data[0], results.data[1], {
          weight: results.data[2]
        });
        gdsGraph.addEdge(results.data[0], results.data[1], results.data[2]);
      }
      interviewer.push(results.data[0]);
      interviewee.push(results.data[1]);
      trusts.push(results.data[2]);
      myResults.push(results.data);
    },
    complete: async results => {
      analyzedData.totEdges = analyzedData.edges - analyzedData.selfLoops;
      analyzedData.probPositive = analyzedData.posTrust / analyzedData.edges;
      analyzedData.probNegative = 1 - analyzedData.probPositive;

      let cliq = jsnx.findCliques(graph, "weight");
      console.log(cliq);
      let test = jsnx.triangles(graph);
      let count = 0;
      test.forEach(element => {
        if (element > 0) {
          count++;
        }
      });
      count /= 3;
      console.log(count);
      let TTT = 0,
        TTD = 0,
        TDD = 0,
        DDD = 0;
      let data = {};
      let myCount = 0;

      let ah = jsnx.getEdgeAttributes(graph, "weight");
      console.log(data);
      // let serialized = gdsGraph.serialize();
      // console.log(serialized.links);
      // console.log(data);
      console.log(myCount / 3);
    }
  });
}
parse();

/*
    TTT
    TTD = TTD
    TDT = TTD
    TDD = TDD
    DDD
    DDT = TDD
    DTD = TDD
    DTT = TTD
*/
