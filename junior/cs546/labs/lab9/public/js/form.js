(function() {
    let primeMethods = {
        isPrime: function(num){
           // console.log(typeof num);
            if(typeof num !== 'number'){
                throw new Error('Please input a number');
            }
            if(isNaN(num)){
                throw new Error('Not a number');
            }
            if(num <= 1){
                return false;
            }
            if(num == 2){
                return true;
            }
            var primeTest = true;
            for(var i=2; i<num; i++){
                if(num % i == 0){
                    primeTest = false;
                    break;
                }
            }
            return primeTest;
        }
    };

    var staticForm = document.getElementById("static-form");
    if(staticForm){
        AttemptsList = document.getElementById("attempts");
    

        staticForm.addEventListener("submit", function(event) {
            event.preventDefault();
            var isPrime = primeMethods['isPrime'];

            var errorTextElem = document.getElementById("error-container");
            try{
                var textArea = document.getElementById("prime").value;
                if(textArea === ""){
                    throw new Error("Please provide a value");
                }
                else{
                    errorTextElem.classList.add('hidden');
                }
                var li = document.createElement("li");
                //console.log(textArea);
                var result = isPrime(parseInt(textArea));
                var textnode;
                if(result){
                    li.classList.add('is-prime');
                    textnode = document.createTextNode(textArea + " is a prime number");
                }else{
                    li.classList.add('not-prime');
                    textnode = document.createTextNode(textArea + " is NOT a prime number");
                }

                li.appendChild(textnode);
                AttemptsList.appendChild(li);
            } catch(e){
                errorTextElem.classList.remove('hidden');
                errorTextElem.textContent = e;
            }
        });
    }
})();