// Christopher Rudel
// CS523
// Calculator
//
//  ViewController.swift
//  Calculator_Rudel_Christopher
//
//  Created by Chris Rudel on 1/29/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var firstNumber = ""
    var secondNumber = ""
    var operand = ""
    var result:String = ""
    
    @IBOutlet weak var myOutputLabel: UILabel!
    
    @IBAction func myZero(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        // What the above code is doing is setting a variable equal to the string inside
        // the optional that is in the text field of myOutputLabel.text and if the string
        // is nil inside said optional then it sets it equal to ""
        if(operand == ""){
            firstNumber += "0"
            myOutputLabel.text = lblText + "0"
        }else{
            secondNumber += "0"
            myOutputLabel.text = lblText + "0"
        }
    }
    @IBAction func myOne(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "1"
            myOutputLabel.text = lblText + "1"
        }else{
            secondNumber += "1"
            myOutputLabel.text = lblText + "1"
        }
    }
    @IBAction func myTwo(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "2"
            myOutputLabel.text = lblText + "2"
        }else{
            secondNumber += "2"
            myOutputLabel.text = lblText + "2"
        }
    }
    @IBAction func myThree(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "3"
            myOutputLabel.text = lblText + "3"
        }else{
            secondNumber += "3"
            myOutputLabel.text = lblText + "3"
        }
    }
    @IBAction func myFour(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "4"
            myOutputLabel.text = lblText + "4"
        }else{
            secondNumber += "4"
            myOutputLabel.text = lblText + "4"
        }
    }
    @IBAction func myFive(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "5"
            myOutputLabel.text = lblText + "5"
        }else{
            secondNumber += "5"
            myOutputLabel.text = lblText + "5"
        }
    }
    @IBAction func mySix(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "6"
            myOutputLabel.text = lblText + "6"
        }else{
            secondNumber += "6"
            myOutputLabel.text = lblText + "6"
        }
    }
    @IBAction func mySeven(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "7"
            myOutputLabel.text = lblText + "7"
        }else{
            secondNumber += "7"
            myOutputLabel.text = lblText + "7"
        }
    }
    @IBAction func myEight(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "8"
            myOutputLabel.text = lblText + "8"
        }else{
            secondNumber += "8"
            myOutputLabel.text = lblText + "8"
        }
    }
    @IBAction func myNine(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        if(operand == ""){
            firstNumber += "9"
            myOutputLabel.text = lblText + "9"
        }else{
            secondNumber += "9"
            myOutputLabel.text = lblText + "9"
        }
    }
    
    @IBAction func myEquals(_ sender: Any) {
        let first = Double(firstNumber) ?? 0
        let second = Double(secondNumber) ?? 0
        // "?? 0" means that 0 is the default value
        if(operand == "+"){
            result = String(format:"%g", first + second)
        }else if(operand == "-"){
            result = String(format:"%g", first - second)
        }else if(operand == "/"){
            if(second == 0){
                result = "Divide by 0 error"
            }else{
                result = String(format:"%g", first / second)
            }
        }else{
            result = String(format:"%g", first * second)
        }
        myOutputLabel.text = result
        firstNumber = result
        secondNumber = ""
        operand = ""
        result = ""
        //print(result)
    }
    
    @IBAction func myClear(_ sender: Any) {
        myOutputLabel.text = ""
        result = ""
        firstNumber = ""
        secondNumber = ""
        operand = ""
        result = ""
    }
    
    @IBAction func myAddition(_ sender: Any) {
        let lblText = myOutputLabel.text ?? "" //the default condition "" should never occur but its necessary syntax
        operand = "+"
        myOutputLabel.text = lblText + "+"
    }
    @IBAction func mySubtraction(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        operand = "-"
        myOutputLabel.text = lblText + "-"
    }
    @IBAction func myDivision(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        operand = "/"
        myOutputLabel.text = lblText + "/"
    }
    @IBAction func myMultiplication(_ sender: Any) {
        let lblText = myOutputLabel.text ?? ""
        operand = "*"
        myOutputLabel.text = lblText + "*"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

