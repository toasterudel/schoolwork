#lang eopl  ;Always remember this line so that DrRacket uses 
;the correct interpreter

; lab1 assignment Spring 2016     
; Friday, September 16, 2016

; Objectives: Get familiar with using DrRacket to edit definitions and 
;interpret expressions.  Get familiar with the built-in boolean 
;operators.  

; Instructions: In the DrRacket edit window, make a file lab1sol.rkt.

; Make sure you are using #lang eopl in the first line.

; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat.

; Some basic logic operators, defined in terms of Scheme's built-in 
;and,or,not 

;Remember that Scheme uses prefix notation, e.g., "x /\ y" gets written 
;"(and x y)".

; Remember: The DrRacket implementation is case-sensitive.  That means 
; that or, Or, and OR are all viewed differently by the interpreter.  
; You're going to get some errors today.  Keep all this in mind as you
; go.  All of Scheme's built-in functions are all lower case.  At least,
; I can't think of any exceptions right now.

; PART 1:  Defining common binary logical operators 
; PART 2:  Testing commutativity of logical operators
; Part 3:  Verifying logical laws
; Part 4:  Defining ternary (3-argument) logical operators
; Philosopher's stone  ?????????

; PART 1:  Defining logical operators

; (a) nand

; Here's a logic operator we may not have mentioned in class, but you 
; can read about it in the 1.3 problems (page 36) section of ROSEN 
; beginning just after #45. "nand" means "not and"; seem reasonable?

;The truth table for "nand" looks like this:
;((#t #t) #f)
;((#t #f) #t)
;((#f #t) #t)
;((#f #f) #t)

(define (nand p q)
  (not (and p q)))

;Test this out with:  (nand #f #f) to make sure the results match the 
;truth table.  Try out all four combinations of #t and #f to verify it.

; (b) if->then

;We certainly did look at "if->then" in class.
;It's truth table looks like this:

;((#t #t) #t)
;((#t #f) #f)
;((#f #t) #t)
;((#f #f) #t)

;It can be "computed" with this:
(define (if->then p q)  
  (or (not p) q))

;Is that right?  Can it be that "if->then" is really a 
;combination of an "or" and a "not"?  
;Does that make sense?

;Test all four combination of #t and #f for p and q to
;verify that the definition is indeed correct.

(if->then #f #t) ;etc....

; (c) xor

;Now it's your turn to define a simple binary logical operator
;In this case, "binary" means that the function takes exactly
;two arguments (inputs).

; "xor" is short for "exclusive or".  It is TRUE when EXACTLY
; one of its arguments is TRUE (and the other is FALSE).
; You get one OR the other, but not both.

;The truth table for "xor" looks like this:
;((#t #t) #f)
;((#t #f) #t)
;((#f #t) #t)
;((#f #f) #f)

(define (xor p q)
  (not (equal? p q)))

;HINT:  Say it out loud, and remember that "but" means "and not".

;Your CA will check your definition.

; PART 2:  Testing commutativity of logical operators

; We have three "new" operators, so we'd like to get to know them 
;better.  At the same time, we'll tinker a little more with Scheme.

;One question to ask about a binary operator is whether it is ;commutative.  Simply put, does it matter in which order we make the
;input assignments.  The addition operation, for example, is
;commutative:  x + y always equals y + x.  Subtraction, however, is
;not commutative.  Sometimes x - y does not equal y - x.

;(a)  nand  (again)

;So, is "nand" commutative, and how can we test it?

(define (nand-commute? p q)
  (equal? (nand p q) (nand q p)))

;If we try all four #t/#f combinations, and ALWAYS get #t, then
;nand commutes, that is, nand is a commutative operation.
;If it comes up #f even once, it does not commute.

;Well?  Is it?  (HINT: You can tell by looking at the truth table.)

;You can cut & paste these to test NAND's commutative property
(nand-commute? #t #t)
(nand-commute? #t #f)
(nand-commute? #f #t)
(nand-commute? #f #f)


; OK, this is a valid law about NAND, so it should return true no
; matter what arguments you try. 
; (In other words, (p nand q) <--> (q nand p) is a tautology.)
; Have we gotten that far in class?

; (b) if->then  (again)

; Do we really need to go through all of this AGAIN for
; if->then?  On the one hand, we'd like to test it. On the
; other hand, it seems like a lot of work for not much.
; (We DO already know the answer, right?)

; So let's be a little clever.  Let's have program that checks
; all four combinations at once.  All must be #t for the 
; function to be TRUE.  That sounds like an "and":

(define (if->then-commute? p q)     
  (and (equal? (if->then #t #t) (if->then #t #t))
       (equal? (if->then #t #f) (if->then #f #t))
       (equal? (if->then #f #t) (if->then #f #t))
       (equal? (if->then #f #f) (if->then #f #f))))

;If you look closely, you'll find that pretty.
;If you look even more closely, you might start asking questions.
;Do we really need the #t #t and the #f #f lines?  I mean,
;won't those ALWAYS be true, for anything at all?  x = x ?
;And aren't the middle two lines really the same?
;Couldn't we get away with something like this:

(define (if->then-com? p q)     
  (equal? (if->then #t #f) (if->then #f #t)))

;Doesn't that seem clever?

;One more question....
;What are the p and q used for?  In order to call the function
;we must put values in for p and q, but we never use them.

;Can we just leave them out?

(define (if->then-c?)     
  (equal? (if->then #t #f) (if->then #f #t)))

;Can a function take NO arguments?  How do we call THAT function?

;Can it be as simple as:

(if->then-c?)

;Sure thing.  We will develop such things only rarely, but a function
;that takes no arguments makes perfect sense.

;What time is it?  What's your computer's serial number?
;Function calls like that don't depend on any particular value.

;What's left?  We have one more.  "xor".  Do we really have to do
;this AGAIN?  Must we do this for EVERY binary logical operator? Well, 
;yes and no.  Another great feature of Scheme is that it treats 
;procedures as first-class objects.  That means that functions themselves
;can be treated as "data" and passed to functions (and returned as 
;values).  So let's do that:

(define (commutes? operator);The input "data" here will be function names
  (equal? (operator #t #f) (operator #f #t)))

;You can now try:
(commutes? nand)
(commutes? if->then)


;And the operator acts as an argument now.
;Sadly, this won't work for "or" nor for "and" because they
;can take more than two arguments.  But we can define:

(define (or2 p q)
  (or p q))

(define (and2 p q)
  (and p q))

;Since these take just two arguments, our (commutes? operator)
;predicate will work on them.  Try it!

;Are those answers correct?


;I hope your defintion of xor from PART 1 is correct, because your CA 
;will ask you whether xor commutes.  Does it?


; Part 3:  Verifying Logical Laws

; Verifying logical laws will look much like what we've done already,
; so we'll try to leverage the work we've just done into something
; useful.

; In fact, two of the laws we know are the "commutative laws" of
; both "and" and "or":

; p /\ q (equiv) q /\ p
; p \/ q (equiv) q \/ p

; and by showing that those operators commute, we verified these laws.
; We showed that the left side is always equal to the right side.

; So let's build a function that checks all possible "left" sides
; against all possible "right" sides for all #t/#f combinations.

(define (law-binary? left right)
  (and (equal? (left #t #t) (right #t #t))
       (equal? (left #t #f) (right #t #f))
       (equal? (left #f #t) (right #f #t))
       (equal? (left #f #f) (right #f #f))))

;Let's VERIFY DeMorgan's Laws:

;(1)  ~(p /\ q)  equiv  ~p \/ ~q

;That says, "not (p and q) is the same as not p or not q.
;That left side is "not and"--that's "nand"  we've already done that!
;The right side...well...

(define (not-p-or-not-q p q)
  (or (not p) (not q)))

;Easy enough?  If we have done this right:

(law-binary? nand not-p-or-not-q) ;should return #t

;(2)  ~(p \/ q)  equiv  ~p /\ ~q

;That says, "not (p or q) is the same as not p and not q.
;That left side is "not or"--that's "nor".  Scavenge code from "nand"
;and you're home free.
;The right side...well...make your own "not-p-and-not-q":

(define (nor p q)
  (not (and p q)))

(define (not-p-and-not-q p q)
  (and (not p) (not q)))

;Show your CA that:
(law-binary? nor not-p-and-not-q)
;verifies DeMorgan's Law  (evaluates #t)

;but p nand q (equiv) p nor q  is not a logical law because
(law-binary? nand nor) 
;evaluates false

;We could extend this idea to (law-ternary? p q r) with
;left and right sides that have as many as three arguments each,
;but we'll just do a couple simple ternary functions and call it
;a fair day.

; PART 4:  Defining Ternary Logical Operators

;(1) 3majority

;Create a function that returns #t when a majority of its three
;arguments are #t:

(define (3majority p q r)
  (or (and (equal? p #t) (equal? q #t)) (and (equal? q #t) (equal? r #t)) (and (equal? p #t) (equal? r #t))   ))

;The truth table for 3majority looks like this:

;((#t #t #t) #t)
;((#t #t #f) #t)
;((#t #f #t) #t)
;((#t #f #f) #f)
;((#f #t #t) #t)
;((#f #t #f) #f)
;((#f #f #t) #f)
;((#f #f #f) #f)

;HINT:  Your definition must include each of p, q, r.  However, ;individual pieces of your definition may include just one or two of 
;them.

;(2) isosceles

;Create a function that returns #t when exactly two of its three
;arguments are #t:

(define (isosceles p q r)
  (and (xor (and p q) r) (xor (and q r) p) (xor (and p r) q)))

;The truth table for isosceles looks like this:

;((#t #t #t) #f)
;((#t #t #f) #t)
;((#t #f #t) #t)
;((#t #f #f) #f)
;((#f #t #t) #t)
;((#f #t #f) #f)
;((#f #f #t) #f)
;((#f #f #f) #f)

;HINT:  Same hint?


;Your CA will test 3majority and/or isosceles


; Philosopher's stone (if->then-if->then)     

;Hagrid's voice boomed from inside his cabin.

;"What?" asked Harry.  "The barking is so loud it sounds like he's got
;THREE dogs in there."

;"He either said 'If you have a piece of meat to distract Fang, then if 
;you knock on the door then it will be safe for you to come in,' or 'If 
;if you have a piece of meat to distract Fang then you knock on the 
;door, then it will be safe for you to come in,'" replied Hermione.

;"That's just the same thing," shouted Ron Weasley.

;Harry and Hermione exchanged a look between them and Hermione said, "I 
;don't think those things are the same at all!"

;You must settle the question of if-then associativity.

;That is, you must determine whether:

;    p -> ( q -> r) (EQUIV) ( p -> q ) -> r 

; represents a logical (ternary) law.

; You may employ techniques from PART 2 or from PART 3.
; PART 2 is easier, even though you might have to test how many
; #t/#f combinations? Using PART 3 is definitely more fun, but you do 
; have to build all that stuff in.

; And, yes, this is actually a question of "associativity"
; rather than "commutativity", but the same ideas apply.


;Hint #1:  Harry and Hermione and Ron do not know about truth tables, 
;but you do.  So you can determine the answer by hand.  This way you can 
;test your code which tests this property.  

;Hint #2:  The definition of if->then from Part 1 is a pre-made piece 
;you can use, if you like.



;You may have noticed that Scheme lets us do some weird naming things.
;We used ">" in if->then, and we started 3majority with a numeral.
;Most languages don't permit this sort of tomfoolery; it's actually
;considered poor style.  Don't do it often; don't get carried away.

;I had a reason to do it in this simple context --> I wanted to show you
;that it IS possible.  

;September 2016
;Srinivas Sridharan and Michael Engling
;Stevens Institute of Technology
;CS 135  Discrete Structures




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
; Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))

