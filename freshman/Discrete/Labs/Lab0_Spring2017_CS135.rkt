#lang eopl ;This tells your interpreter which version of Scheme to use

; lab0 assignment Fall 2016     
; Friday, September 19, 2016

; Objectives: Get familiar with using DrRacket to edit definitions and 
;interpret expressions.  

; Instructions: In the DrRacket edit window, make a file named: 
; lab0sol_your_name.rkt

; Always make sure you are using #lang eopl in the first line.
; The eopl stands for "Essentials of Programming Languages".
; It follows a text we use at Stevens (CS 496 & CS 510) to study the 
; theory of programming languages.

; Read through the rest of this file.  As you go, add the Scheme 
;definitions to your file, one at a time.  Click 'run' for each one, and 
;fix syntax errors before proceeding to the next.  Additional 
;instructions appear in *** comments below. 

; Note: You don't need to type in the comments, but do use menu 
;Scheme/reindent to keep the indentation neat.

;Scheme comments begin with a semicolon, like this:  ;
;For some of the entries below, all you'll have to do is delete the ";"
;and press the green "RUN" button in the upper right. (Not the "debug" 
;button.)

; Since we haven't had a single class meeting yet, we can't do a great
; deal of stuff, but we CAN investigate the basics of how Scheme works.

; We'll start by looking at how Scheme does basic arithmetic and how it 
;handles simple pieces of data/information.

;Part 0:  Download DrRacket and get it going.
;Part 1:  Arithmetic Operations and Comparsions
;Part 2:  Simple Predicates
;Part 3:  Simple Data Types
;Part 4:  Built-in and User-Defined Operations
;Monalisa Golden-Ratio:  ???????

;Part 0:  Download DrRacket and get it going.
;If you're reading this, you've made Part 0 work.
;Well done.  Let's move on.


;Part 1:  Arithmetic Operations and Comparisons

;Scheme is a computer language--you can use Scheme to compute.
;However, Scheme is a functional language.  You're probably familiar 
;with Matlab or Python or Java or C/C++.  Although they have their 
;differences, they are all (essentially) imperative languages.  You code 
;them by starting at the beginning, going on until you reach the end, 
;and then stopping.

;Functional languages work differently; they have a sort of inside-out & 
;all-at-once feel to them.  (Microsoft EXCEL is a variant of a 
;functional language, so if you have ever really written a spreadsheet 
;with it, you've done some functional programming.)

;Scheme code is written in PREFIX notation.  That means that instead of 
;writing "3 + 5", we'll write "+ 3 5" to add three and five.
;Furthermore, in order to tell Scheme you mean it, you must put the 
;expression in parentheses, like this:

(+ 3 5)

; Hit the green RUN button, and enter that in the interactive window 
;below:

;Simple.

;How about multiplication?  Like many languages, Scheme uses the asterisk
;to signify multiplication.  Use the same form, and try it:

(* 3 5)

;What about subtraction and division?

(- 3 5)
(/ 3 5)

;Do those give you the answers you expected?   Really?
;I'm guessing you got a bit of a surprise with one of them.
;(We'll talk more about it in Part 3.)

;Of course, the order is important here, unlike + and * which 
;are commutative operations.

(- 5 3)
(/ 5 3)

;Why insist on PREFIX notation, you ask?  Well, there are many reasons, 
;but try this on for size:

(+ 1 2 3 4)

;and

(* 1 2 3 4 5)

;Slick, no?

;I wonder what you'd get with

(- 1 2 3 4) 
(/ 1 2 3 4 5)

;Intrigued?

;What about comparing numbers?  Can we ask:  is 3 equal to 5?
;Yes, in precisely the same way (try it):

;(= 3 5)

;The answer you got was #f.
;If you ask (< 3 5) you should get a different answer.

;Scheme represents Boolean values, True and False, as #t and #f, 
;respectively.  But we're getting a little ahead of ourselves.

;Are there other comparison operators?  What do you think?
;Try the ones you think might work.  You should be able to find at
;least three more without breaking a sweat.
;Test them.  Do they behave the way you expect?

;Go ahead.  I'll wait.

;Did you find one for "not equals"?
;C/C++ uses !=
;Matlab uses ~=
;Old BASIC used <>

;Scheme is so literal it actually uses the word "not" as an operator:

;(not (= 3 5))

;Try that.  (But now we're REALLY getting ahead of ourselves. We'll deal 
;with that next week in Lab 1.)

;NOTE: The DrRacket implementation is case-sensitive.  That means that
;not, Not, and NOT are all viewed differently by the interpreter.  
;You're going to get some errors today.  Keep all this in mind as you 
;go.

;Your CA will ask you to perform a simple calculation with a pair of
;integers.  Use the right prefix form to answer your first question of
;the semester.


;Part 2:  Simple Predicates

;Basically, predicates are expressions that evaluate to TRUE or FALSE
;depending on the inputs to the expressions.  We already saw the basic
;comparison operators: =, <, etc.  These are the simplest predicates, and
;they are so commonly used that they get their own symbols.

;But there are lots more questions (predicates) we may want to ask about
;all sorts of things:

;(number? 23)
;(number? #t)
;(equal? 3 5)
;(odd? 3)
;(positive? -7)
;(even? 5)
;(zero? 15)

;There's a lot there to unpack.  We really are getting ahead of 
;ourselves.

;Do you see that each of those expressions/statements has the same
;PREFIX form in parentheses?  That's what Scheme will always look like.

;When you typed them out, did you remember the question mark at the end?
;All of Scheme's built-in predicates end with a question mark, and when
;we write our own, we'll adopt that naming convention to remind ourselves
;that the function returns Boolean values:  #t & #f.

;Did you notice that there is a predicate "equal?" ?
;"=" can be used only to compare numbers.
;"equal?" will allow us to compare all sorts of things that are NOT
;numbers.

;Try these:  (= #f #f)  and (equal? #f #f)
;There are deep details here we'll revisit several times.
;We don't want to get THAT far ahead of ourselves now.

;There are some tricks and traps to be aware of.  Try this:

;(= (/ 2 5) (/ .2 .5))

;What's going on there?  Well, the first entry up there is done
;with integer arithmetic while the second one is computed with
;floating point arithmetic.  The numbers aren't represented in 
;memory the same way, and the comparison comes up "wrong".

;And try this:
;(zero? (- (/ 2 5) .4))         (They're equal after all.)

;Always keep in mind that when you use "=" on numbers, you may get
;incorrect results if you don't use numbers of the same type.

;Your CA will ask you something about a number's sign or parity.
;have a predicate or two ready to answer the question!

;That brings us to...


;Part 3:  Simple Data Types

;Like most languages, Scheme handles different "types"
;of information differently.  We'll focus on a small
;collection of types.

;We'll almost never work with strings, but most
;programming manuals start with a "Hello, World!"
;program.  Here's yours for today:

"Hello, World!"

;We'll deal mostly with integers and Booleans (which we've 
;already seen today) and lists and pairs (which we'll save for
;upcoming labs--Rome wasn't built in a day.)

;Each type has a predicate associated with it:  (Try these.)

;(number? 5)
;(boolean? 5)
;(integer? 3.2)
;(string? "Hello, World!")

;You get the picture.  There are others, but we'll keep ourselves
;limited to some core types.

;One other perhaps worth knowing is the type "procedure".
;We have called Scheme a "functional" language, and we'll define
;our own functions shortly.  We discussed arithmetic "operators"
;earlier.  But the technical term, the "type", for functions and
;operators is "procedure".  That means the type's predicate is:
;"procedure?"  Try these, too:

;(procedure? +)
;(procedure? #f)
;(procedure? odd?)
;(procedure? 17)

;Let's do some actual programming.

;For your CA:  Use some simple predicates to silently explain the
;difference between 3 and "3".  Make sure you can get a #t for each
;(with different predicates, of course.)


;Part 4:  Built-In and User-Defined Functions

;We've already seen many built-in functions--all those predicates
;are examples of built-in functions. But we'd like to do some 
;computing with numerical functions.

;My iPhone has a scientific calculator in it--I certainly expect to be
;able to do on my computer with Scheme anything I can do on my iPhone.

;Some of the most obvious buttons are the trig functions: sine, cosine, 
;and tangent.  You can experiment if you like to see whether those are
;built-in functions in Scheme.  (They are, but this is a "discrete" class
;not calculus, so I want to look at something else for now.

;What about the square root button?  We don't have a symbol on our
;keyboards for that.  All our functions have word-like names.  But surely
;we can compute a square root simply.  You bet.

;(sqrt 100)
;(sqrt 2)

;How about logarithms?  Most scientific calculators have separate buttons
;for common logs (base 10) and natural logs (base e).

;What is the base of Scheme's log function?

;(log 100)

;Did you know that those buttons on you calculator are redundant?
;That is, if you have a "log x" button, you can compute natural logs 
;with it, and if you have a natural log button ("ln x"), you can compute 
;common logs with it? You only need one log operator to compute logs 
;with ANY base.

;The simple conversion formula looks like this:
; log_b x = log_a x / log_a b.

;In tortured English, that means that if you want a log function with a 
;new base, you merely divide the old function by the log of your new 
;base (in the old function.)

;Common logs are for engineers, and natural logs are for scientists.  
;We're computer scientists, so we need logs with a base of 2.  We do 
;binary (base 2), octal (base 8), and hexadecimal (base 16).  We deal in 
;k (2^10), megs (2^20), gigs (2^30), and so on.  We need a log base 2.

;So let's make it.

;The formula above says log2 x = log x / log 2, whatever the base of "log" is.  (Did you work it out?)

;The log base 2 of 1024 is 10, so this should give 10:

;(/ (log 1024) (log 2))

;Does that work?
;Even if you can get that to work, it would be inconvenient to put that 
;expression in every time you need it.  Wouldn't it be nice to be able
;to use (log2 x) for the log base 2 just like we have (log x) for
;whatever base log that is?  (No, really, did you work out the base of 
;the built-in log?)

;Defining functions like this is the essence of what we'll do in Scheme
;all semester.  We just need a way of including a parameter (a blank)
;instead of hard-coding that 1024.  We need the special keyword "define".

;(define (log2 x) (/ (log x) (log 2)))

;Give that a try, and then follow it with (log2 1024)
;And try (log2 16), (log2 1000), etc.

;We'll often do this by writing the "define" on the first line, and
;the computation (body of the function) on the second line.  Like this:

(define (lg x)         ;name & parameters //This is a base-2 logarithm
  (/ (log x) (log 2))) ;body of computation in parentheses

;Note that this is in the definitions window.  Now any time you wish, you
;can compute (lg x) in the interactive window without retyping this.
;Try it!

;That's a taste of what we'll do all semester.

;For your CA:
;Examine:
;(exp -1)
;(exp 0)
;(exp 1)
;(exp 5)

;And whisper to your CA what function "exp" represents in Scheme.


;GOLDEN RATIO

;Today's GOLDEN RATIO problem attempts to put this all together.

;In addition to functions, sometimes it's convenient to name numbers.

;The number pi comes to mind.

(define pi 3.14159265)

;Take that ";" off, and you'll have pi any time you want it in the 
;interactive window.  Give it a try. (Be sure to RUN again.)

;You can also define the square root of two:

(define root2
  (sqrt 2))

;And now you have the square root of two by name.

;Another number we'll have reason to bump into from time to time is the
;Golden Mean.  Just as pi is known by a lower-case Greek letter, the 
;Golden Mean is often designated by the lower-case Greek letter phi.
;The lower case of the Greek letter is usually pronounced "fee" rather
;than "fie" when it shows up in mathematics.

;The Golden Mean is (1 + SQRT (5)) / 2.

;http://en.wikipedia.org/wiki/Golden_ratio

;Your job is to complete the computation in the definition:
;(Yes, it must be a computation as the body, not the decimal number.)
;HINT:  Scheme has an "inside-out" look and feel, so the first
;operation will be the most deeply nested one, and the last operation
;will appear first when read, naively, left to right.

(define phi
  (/(+ 1 (sqrt 5)) 2)) ;Don't forget the interior parentheses!


;Next week:  Propositional/Predicate Logic


;* The syntax for the Boolean type predicate is "boolean?" with a lower
;case "b", as all built-in functions are lower case.  (I think!)
;But the word "Boolean" comes from the name of George Boole, an
;important logician from the 19th century.  For that reason, I try to 
;capitalize it consistently when I can.
;http://en.wikipedia.org/wiki/George_Boole

;September 2016
;Srinivas Sridharan and Michael Engling
;Stevens Institute of Technology
;CS 135  Discrete Structures


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; This definition isn't needed for the lab, but you will need to 
; include it in your DrRacket files when you start studying the Little 
;Schemer.


(define (atom? x) (and (not (pair? x)) (not (null? x))))
