/*
 * Christopher Rudel
 * Assignment 1: Intro to Swift
 * 1/22/19
 * I pledge my honor that I have abided by the Stevens Honor System
 */
import UIKit

func exercise1() {
    print("First exercise: ")
    var myLoan:Double = 1000
    var count = 0
    print("Initially at month 0 we have an outstanding balance of $1000 and a compound interest rate of 2%")
    while(myLoan > 0)
    {
        count += 1 // We pay at the end of the month
        var rate = 0.02
        if(myLoan < 500)
        {
            rate = 0.01
        }
        let interest:Double = myLoan * rate
        myLoan += interest
        if(myLoan < 100)
        {
            myLoan -= myLoan
        }else{
            myLoan -= 100
        }
        if(myLoan < 500)
        {
            rate = 0.01
        }
        print("At the end of month \(count) there is an outstanding balance of $\(myLoan) with interest rate \(rate*100)%")
    }
    print("")
    
}

func exercise2(Weather: Int, Schedule: Int, LikeRunning: Int) {
    print("Second exercise: ")
    if(LikeRunning >= 4){
        if(Schedule > 2)
        {
            print("Not going for a run\n")
        }else if(Weather > 45 && Weather < 90)
        {
            print("Going for a run\n")
        }
        else{
            print("Not going for a run\n")
        }
    }else{
        print("Not going for a run\n")
    }
}
func exercise3(runnerList: [(_:String, _:Int)]){
    print("Third exercise: ")
    var name = "Placeholder"
    var fastestTime = 100000
    for (runner, time) in runnerList{
        if(time < fastestTime){
            name = runner
            fastestTime = time
        }
    }
    
    print("The fastest runner was \(name) with a time of \(fastestTime) minutes")
}

exercise1()
exercise2(Weather:89, Schedule:2, LikeRunning:4)
let marathonRunners: [(Name: String, Time: Int)] = [("Elena", 341), ("Thomas", 273), ("Hamilton", 278), ("Suzie", 329), ("Phil", 445), ("Matt", 402), ("Alex", 388), ("Emma", 275), ("John", 243), ("James", 334), ("Jane", 412), ("Emily", 393), ("Daniel", 299), ("Neda", 343), ("Aaron", 317), ("Kate", 265)]
exercise3(runnerList: marathonRunners)

