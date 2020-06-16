# I pledge my honor that I have abided by the Stevens honor system.
#Meng Qiu, Kaitlynn Prescott, Christopher Rudel

fo=open("input10.txt","r")
listOfnum = fo.readlines()
#Reads data from text file

s=map(lambda s:s.strip(),listOfnum)
#Removes "\n'


def hugeSum(s):
    #Implements Large Sum Algorithm
    carry=0
    ans=0
    result=""
    n=0
    while(n<=len(s)+2):
        # Checks any non empty number in the list
        ans=ans+carry
        carry=0
        for i in range(len(s)):
            # Adds numbers 9 by 9 digits
            if s[i]=="":
                s[i]="0"
            ans+=int(s[i][-9:-1]+s[i][-1]) 
            if ans >= 10**9:
                carry+=1
                ans=ans%(10**9)  
            s[i]=s[i][:-9]
        if ans==0 and carry!=0:
            result='0'*9+result
        else:
            result=str(ans)+result
            #Puts integer answer into answer string
        ans=0
        n+=1
        if "" in s:
            s.remove("")
    return result


sumOflist=hugeSum(s)

#Removes 0s from the outpt
for i in sumOflist:
    if i!="0":
        break
    else:
        sumOflist=sumOflist[1:]
