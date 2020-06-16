const papa = require("papaparse");
const fs = require("fs");
const file = fs.createReadStream("epinions96.csv");
const Graph = require("graph-data-structure");
const graph = Graph();
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
  let count = 0;
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
        graph.addEdge(results.data[0], results.data[1]);
      }
      interviewer.push(results.data[0]);
      interviewee.push(results.data[1]);
      trusts.push(results.data[2]);
      myResults.push(results.data);
      count++;
    },
    complete: async results => {
      analyzedData.totEdges = analyzedData.edges - analyzedData.selfLoops;
      analyzedData.probPositive = analyzedData.posTrust / analyzedData.edges;
      analyzedData.probNegative = 1 - analyzedData.probPositive;
      console.log(analyzedData.totEdges);

      let count = 0;
      let TTT = 0,
        TTD = 0,
        TDD = 0,
        DDD = 0;

      let myCount = 0;
      let serialized = graph.serialize().links;
      //   console.log(serialized);
      //   graph.edges().forEach(element => {
      //     let [uint, vint] = element;
      //     let u = uint.toString();
      //     let v = vint.toString();
      //     graph.nodes().forEach(wint => {
      //       let w = wint.toString();
      //       if (graph.hasEdge(v, w) && graph.hasEdge(w, u)) {
      //         myCount++;
      //         // console.log(u, v, w);
      //         // if (graph[u][v] > 0 && (graph[v][w] > 0)(graph[u][w] > 0)) {
      //         //   // TTT
      //         //   TTT++;
      //         // }
      //         // if (graph[u][v] < 0 && (graph[v][w] < 0)(graph[u][w] < 0)) {
      //         //   // DDD
      //         //   DDD++;
      //         // }
      //         // if (graph[u][v] > 0 && (graph[v][w] > 0)(graph[u][w] < 0)) {
      //         //   // TTD
      //         //   TTD++;
      //         // }
      //         // if (graph[u][v] > 0 && (graph[v][w] < 0)(graph[u][w] > 0)) {
      //         //   // TDT
      //         //   TTD++;
      //         // }
      //         // if (graph[u][v] > 0 && (graph[v][w] < 0)(graph[u][w] < 0)) {
      //         //   // TDD
      //         //   TDD++;
      //         // }
      //         // if (graph[u][v] < 0 && (graph[v][w] < 0)(graph[u][w] > 0)) {
      //         //   // DDT
      //         //   TDD++;
      //         // }
      //         // if (graph[u][v] < 0 && (graph[v][w] > 0)(graph[u][w] < 0)) {
      //         //   // DTD
      //         //   TDD++;
      //         // }
      //         // if (graph[u][v] < 0 && (graph[v][w] > 0)(graph[u][w] > 0)) {
      //         //   // DTT
      //         //   TTD++;
      //         // }
      //       }
      //     });
      //   });
      console.log(graph.getEdgeWeight("20", "50"));
      console.log(myCount / 3, count / 3);
      console.log(TTT, TTD, TDD, DDD);
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
