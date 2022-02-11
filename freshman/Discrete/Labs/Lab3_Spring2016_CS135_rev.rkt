#lang eopl  ;Always remember this line so that DrRacket uses 
;the correct interpreter

;Christopher Rudel
;2/14/17
;CS135LD
;I pledge my honor that I have abided by the Stevens Honor System
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; lab3 assignment Fall 2016     
; Friday, October 7, 2016

; Objectives: Get familiar with using DrRacket to edit definitions and 
;interpret expressions.  Get familiar with the built-in boolean 
;operators.  

; Make sure you are using #lang eopl in the first line.

; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat.

;PART 0   if
;PART 1   The Commandments
;PART 2   Building Lists
;PART 3   Recursive Predicates
;PART 4   Putting It All Together 
;GOLDEN SNITCH   ????????

;PART 0   if

;There's one thing we haven't done yet that we need for today:
;we need to be able to "branch".  We've asked questions with predicates
;but we haven't yet done anything with the answers.

;Here's how we'll do that:

(define (branch predicate item-to-test)
  (if (predicate item-to-test)
      (display "Yes! Answer was #t")
      (display "Too Bad! It was #f")))

;Try this with your favorite predicates:
;(branch even? 4)
;(branch odd? 4)
;(branch list? empty)
;(branch null? empty)
;(branch zero? 5)

;And that's actually harder than most of what we'll do today because
;we will always build the predicate right into the second line.

;When we are recurring on a list, we'll ask null?
;When we recur on an integer, we'll ask zero?


;In a technical sense, this function is just like all the other
;procedures we have used.  It performs "if" which is a function that 
;takes THREE arguments: the first is any predicate with proper arguments,
;the second is the procedure (also with arguments) to be executed when
;the predicate returns #t, and the third is another procedure (also with
;arguments) to be executed when the predicate returns #f.

;Nearly everything we'll do will be this simple:
;0.  Name the function and parameters
;1.  Ask a question about (at least) one of the parameters.
;2.  Return a value when the answer is #t.
;3.  Return a value when the answer is #f.

;How can we expect to do anything of importance in 4 lines?
;Well, "return a value" will often involve calling another function, and
;that may involve calling yet another function, and that may ...

;...and when the function called is the same as the one doing the 
;calling, that's called recursion.


;PART 1   The Commandments  (basic versions)

;The First Commandment

;When recurring on an integer n, ask two questions about it: 
;(zero? n) and else.

;When recurring on a list-of-things ask two questions about it: 
;(null? list-of-things) and else.   

;The Second Commandment:  Use cons to build lists.
;We did this last week, one piece at a time.
;Today we do it with recursion.

;The Third Commandment:  When building a list, describe the first 
;typical element, and then cons it onto the natu­ral recursion.

;The Fourth Commandment:  Always change at least one argument while 
;recurring: when recurring on a list-of-things use (cdr list-of-things) 
;to make sure the list gets shorter (and ultimately empty), and when 
;recurring on an integer, subtract to make sure the number gets smaller 
;(and ultimately 0). HINT:  The changing argument will always be tested 
;in the termination condition--the second line of the function.

;The Fifth Commandment:  When building a value with + (addition), always 
;use 0 for the value of the terminating line, for adding 0 does not 
;change the value of an addition.  And, ...
;When building a value with x (multiplication), always use 1 for the 
;value of the terminating line, for multiplying by 1 does not change the 
;value of a multiplication. And, ...
;When building a value with cons, always consider () for the value of 
;the terminating line.



;One classic program that most people first see done recursively is
;the computation of a factorial.  So let's do that.

;Factorial n, or, n factorial, written as "n!", is the product of 
;the first n integers.  So 5! = 1 x 2 x 3 x 4 x 5 = 120, but it can also
;be written as 5! = 5 x 4 x 3 x 2 x 1 = 120, and it is this formulation
;that provides the peek inside recursive thinking that we need, because
;5! can also be expressed as 5 x 4!  

;Also, because factorial is multiplicative, and because we want a 
;definition for 0!, we take the multiplicative identity as that value.
;So 0! = 1.  (For much the same reason that 0 as an exponent returns 1.)


;So let's charge right ahead:
(define (factorial n)             ;Name of function and parameters
  (if (zero? n)                   ;At the bottom?  (Base case?)
      1                           ;Answer to base case:  0! = 1
      (* n (factorial (- n 1))))) ;n! = n times (n - 1)!

;Does it work?
(factorial 5)
(factorial 50)
(factorial 0)
;Don't do this: (factorial -1)
;What would happen?  Why?

;OK, so we multiplied the first n integers.  Does that mean anything?
;Actually, the factorial has a very simple application--it's the number
;of possible permutations of n items.  That is, if you ran a race with
;five runners, there would be 5! = 120 possible finishing orders.

;What if we ADDED the first n integers?  Would that mean anything?
;Actually, yes.  Such sums are called triangular:

;n = 0
;n = 1     .
;n = 2    . .      Pawn Shop Sign?
;n = 3   . . .
;n = 4  . . . .    Bowling, anyone?
;n = 5 . . . . .   Billiards, anyone?
;...

;Modify our factorial program to instead add the first n integers:
;(You won't have to change very much.)
(define (triangular n)
  (if (zero? n)
      0
      (+ n (triangular (- n 1)))))

;(triangular 5)   ;[billiard balls]
;(triangular 50) ;[for fun]
;(triangular 0)

;Your TA will check your triangular procedure

;So, simple computations are, well simple.

;Let's do something with a list.  Let's find the sum of a list of 
;integers, but let's do it recursively.

(define lab3ints '(1 2 3 4 5 4 3 2 1))

;What's the sum?  How do you compute it?  How do you compute it 
;recursively?  Scheme allows us 2 basic peeks inside a list:
;(car list-of-things) shows us the first entry, and
;(cdr list-of-things) is all the rest of the things as a list.

;Do you see how to use those pieces to get the whole sum?

(define (sum list-of-nums)
  (if (null? list-of-nums)
      0
      (+ (car list-of-nums) (sum (cdr list-of-nums)))))

;Really, every program we write will have the same shape.
;0.  Name the function and the parameters
;1.  Ask the "Are we done?" question.  In this case, "null?" asks:
;    "Is the list empty?"
;2.  Return the value of the "done" case.  What is the sum of all the 
;    entries in an empty list?  ZERO.
;3.  Return the value when there's real work to do.  This will often be
;    the only line you have to think about.  What are we doing here?
;    Adding.  Adding what to what else?  We are adding the first item
;    (car list-of-nums) to the (sum of all the rest (cdr list-of-nums))

;Try it out:

(sum lab3ints)

;OK, now it's your turn again:
;Write (prod n) that computes the product of numbers in a list

(define (prod list-of-nums)
  (if (null? list-of-nums)
      1
      (* (car list-of-nums) (prod (cdr list-of-nums))))

  )

;Your CA will check your definition!
 

;PART 2   Building Lists

;So far we've done some computations, first with individual numbers, and 
;then with entries of a list.  In each case, we returned a numeric value.

;Now let's build a list.  Let's compute the first n factorials and
;put them in a list.

(define (fact-list n)                             ;name
  (if (zero? n)                                   ;all done?
      '()                                         ;list with 0 entries
      (cons (factorial n) (fact-list (- n 1)))))  ;3rd Commandment

;This should look very familiar by now.  Only the last line is at all
;complicated.  In this case, we find the factorial of the first entry in
;the list, and we use "cons" to the list with 1 fewer factorials in it.

;Write a function to build a list of the first n square integers.
;(You thought I was going to ask for triangular numbers?)

(define (squares n)
  (if (zero? n)
      '()
      (cons (* n n) (squares (- n 1)))))

;Your CA will check your definition


;PART 3   Recursive Predicates

;Sometimes the computation we'll want to do on a list will involve a
;predicate.

;Are all the numbers greater than 0?
;Are there any even numbers in the list?
;Do all of the entries in the list have the prerequites for CS135?

;All of this is just like before, except there's one twist and one rule
;to keep in mind.

;First the new rule:  When writing a predicate, something that returns
;either #t of #f, there must be a way to return #t AND another way to
;return #f.  When you're done, if you don't have a #t line AND a separate
;#f line, you've probably forgotten something.

;What's the twist?  We'll get to that.

;Let's write a function that checks whether all the entries in a list are
;greater than zero:

(define (all-pos? list-of-nums)  ;Familiar?  Note the "?" in the name!
  (if (null? list-of-nums)       ;Still familiar.  
      #t  ;All the numbers in the empty list positive...vacuously.
      (if (positive? (car list-of-nums)) ;Is the car positive?
          (all-pos? (cdr list-of-nums))  ;Yes?  Keep going!
          #f)))                          ;No?   Found a bad one.  #f

;And there's the twist.  The fourth line (the hard line) is an "if" this
;time.  So it looks as if our program is six lines long.  You have to ask
;TWO questions sometimes:  
;"Are we done?" and "What about this first piece?" 


;Now it's up to you:
;Write a function "any-even?" that returns #t if there is at least one
;even number in a list of integers and returns #f otherwise.

;This is exactly the same as the one above but also quite different.
;Consider it your first REAL test.

(define (any-even? list-of-ints)
  (if (null? list-of-ints)
      #f
      (if (odd? (car list-of-ints))
          (any-even? (cdr list-of-ints))
                     #t)))

;Here are some pre-defined lists of integers you can use:
(define test1 '(1 3 5 7 5 3 1))
(define test2 '(2 4 6 8 10 12))
(define test3 '(1 2 3 4 5 6 7 8))
(define test0 '())
(define test5 '(3 2 1 2 4 6))
(define test6 '(2 4 6 1 2 3))

;Your TA will check your function.

;PART 4   Putting It All Together

;Now we're ready to put it all together.

;Let's count the number of odd entries in a list.

(define (count-odds list-of-ints)               ;name
  (if (null? list-of-ints)                      ;Are we done?
      0                                         ;How many odds in empty?
      (if (odd? (car list-of-ints))             ;Is first one odd?
          (+ 1 (count-odds (cdr list-of-ints))) ;Yes? Add it to sum
          (count-odds (cdr list-of-ints)))))    ;No?  Ignore it*

;* The catch here is that if the first number (car l-o-ints) is not
;odd, then the number of odds in the list is the same as the number of
;odds in the cdr of the list.  (count-odds (cdr ...)) returns THAT number
;which is just the number we're after.

;Try it with some of our sample lists:
(count-odds test1)
(count-odds test2)
(count-odds test6)


;Write a function "odds" that takes a list of integers and returns a 
;list consisting of all the odd integers (and only the odd integers),
;in the list.  (Multiples should appear multiple times.)
;Hint:  The program above can serve as a good template to start from.
;What pieces do you have to change?  Why?

(define (odds list-of-ints)
   (if (null? list-of-ints)
       '()
       (if (odd? (car list-of-ints))
           (cons (car list-of-ints) (odds (cdr list-of-ints)))
           (odds (cdr list-of-ints))))

            )

;Hint:  You'll need aspects of all three previous PARTS from today's lab.
;You can use the test lists from PART 3 here, too.

;Your TA will check your program.


;GOLDEN SNITCH:  The SortingHat

;The Sorting Hat can tell which house a new student at Hogwarts best 
;belongs.  Write a function that takes a list of ordered pairs like 
;those below and the name of a house (as a string) and returns the list 
;of the ones belonging to that house:

;(define (SortingHat list-of-pairs house)
;  "your definition goes here")

;are Gryffindor, Hufflepuff, Ravenclaw and Slytherin.

(define alumni '((AlbusDumbledore "Gryffindor") (HengistOfWoodcroft "Hufflepuff") (GilderoyLockheart "Ravenclaw") (Merlin "Slytherin")(HarryPotter "Gryffindor")(NewtScamander "Hufflepuff")(IgnatiaWildsmith "Ravenclaw")(TomRiddle "Slytherin")(CelestineWarbeck "Gryffindor")(ArtemisiaLufkin "Hufflepuff")(GarrickOllivander "Ravenclaw")(DoloresUmbridge "Slytherin")))

(define founders '((Godric "Gryffindor") (Helga "Hufflepuff") (Rowena "Ravenclaw") (Salazar "Slytherin")))

(define ghosts '((NearlyHeadlessNick "Gryffindor") (FatFriar "Hufflepuff") (GreyLady "Ravenclaw") (BloodyBaron "Slytherin")))

(define headmasters '((MinervaMcGonagall "Gryffindor") (PomonaSprout "Hufflepuff") (FiliusFlitwick "Ravenclaw") (SeverusSnape "Slytherin")))

(define mascots '((Lion "Gryffindor") (Badger "Hufflepuff") (Eagle "Ravenclaw") (Snake "Slytherin")))
















(define all (append founders ghosts headmasters mascots alumni))

;October 2016
;Srinivas Sridharan and Michael Engling
;Stevens Institute of Technology
;CS 135  Discrete Structures





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))
