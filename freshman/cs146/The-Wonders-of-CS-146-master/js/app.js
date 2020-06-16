/* Begin app.js */
function formSubmit() {
    var nameInput = document.getElementById('name');
    alert("Thanks for your feedback, " + nameInput.value + "!");
    document.location.href="index.html";
}

var pmQuiz = [
    {
        number: 1,
        text: "The Waterfall Method doesn't include this stage",
        choices: ["Implementation", "Maintenance", "Sobbing in a Corner", "Requirements and analysis"],
        correctAns: "Sobbing in a Corner"
    },
    {
        number: 2,
        text: "What is the most important part of a Requirements Document?",
        choices: ["describe the problem", "how a basic solution to the problem", "express any constraints to the solution", "determine how success will be measured", "All of the above"],
        correctAns: "All of the above"
    }
];


var webQuiz = [
    {
        number: 1,
        text: "What are the benefits of building a network?",
        choices: ["Faster Communication", "Less Expensive Communication", "Backup Services", "All of the above"],
        correctAns: "All of the above"
    },
    {
        number: 2,
        text: "What does a WAN stand for?",
        choices: ["Weird Appetite for Neckbeards", "Wide Acquisition Network", "Wide Area Network", "Working on A Network"],
        correctAns: "Wide Area Network"
    },
    {
        number: 3,
        text: "Javascript?",
        choices: ["Yes", "No", "Batman"],
        correctAns: "Batman"
    }
];


var bgQuiz = [
    {
        number: 1,
        text: "Who was the creator of the first personal computer?",
        choices: ["IBM", "Microsoft", "Apple", "None of the Above"],
        correctAns: "Apple",
        ans: ""
    },
    {
        number: 2,
        text: "In what year was telex implented?",
        choices: ["1933", "1912", "1929", "1945"],
        correctAns: "1933",
        ans: ""
    },
    {
        number: 3,
        text: "Who built the first telegraph system?",
        choices: ["Alexander Graham Bell", "Steve Wozniak", "Samuel Finley Breese", "Nicola Tesla"],
        correctAns: "Samuel Finley Breese",
        ans: ""
    }
];

function getQuestions(page) {
    switch(page) {
        case "background":
            return bgQuiz;
        case "project-management":
            return pmQuiz;
        case "web-basics":
            return webQuiz;
        default:
            return null;
    }
}


function displayQuestion(question) {
    document.getElementById('q-number').innerHTML = "Question " + question.number;
    document.getElementById('q-text').innerHTML = question.text;

    var choices = document.getElementById('choices');
    for(choice in question.choices) {
        var label = document.createElement('label');
        label.innerHTML = question.choices[choice];

        var input = document.createElement('input');
        input.setAttribute('type', 'checkbox');
        input.value = question.choices[choice];

        label.prepend(input);
        choices.append(label);
    }
}

function clearQuestion(page) {
    var choices = document.getElementById('choices');
    while (choices.hasChildNodes()) {
        choices.removeChild(choices.lastChild);
    }
}

function getAnswer() {
    var choices = document.getElementById('choices').childNodes;
    for(var i = 0; i < choices.length; i++) {
        if(choices[i].childNodes[0].checked) {
            return choices[i].childNodes[0].value;
        }
    }
    return 'null';
}

function grade(questions) {
    var score = 0;
    for(var i = 0; i < questions.length; i++) {
        if(questions[i].ans ==  questions[i].correctAns)
            score++;
    }
    return score;
}

function displayGrade(score, totalQuestions) {
    var quiz = document.getElementById('quiz');
    while (quiz.firstChild) {
        quiz.removeChild(quiz.firstChild);
    }
    var grade = (score / totalQuestions) * 100

    var heading = document.createElement("h2");
    heading.innerHTML = "Your score: " + grade + "%";

    quiz.append(heading);
}
    
function quiz(page) {
    var questions = getQuestions(page);
    var currentQuestion = 0;
    var score = 0;
    var totalQuestions = questions.length;

    displayQuestion(questions[currentQuestion]);

    /* Bind buttons */
    document.getElementById("next").onclick = function () { 
        questions[currentQuestion].ans = getAnswer();
        if(currentQuestion < totalQuestions-1) {
            currentQuestion++;
            clearQuestion();
            displayQuestion(questions[currentQuestion]);
        }
    };

    document.getElementById("prev").onclick = function () { 
        questions[currentQuestion].ans = getAnswer();
        if(currentQuestion > 0) {
            currentQuestion--;
            clearQuestion();
            displayQuestion(questions[currentQuestion]);
        }
    };

    document.getElementById("finish").onclick = function () { 
        questions[currentQuestion].ans = getAnswer();
        score = grade(questions);
        displayGrade(score, totalQuestions);
    };   
}

(function() {
    document.addEventListener("DOMContentLoaded", function() {
        var page = document.getElementsByTagName("body")[0].id;
        quiz(page);
    });
})();