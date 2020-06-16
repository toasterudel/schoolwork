//
//  ViewController.swift
//  TicTacToe
//
//  Created by Chris Rudel on 3/17/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//  CS 523
//  I pledge my honor that I have abided by the Stevens Honor System
//
//
//  Please note the app works the best on iphone xr or xs mas


import UIKit

class ViewController: UIViewController {
    var winner = 0
    var firstPlayer = "Player One"
    var secondPlayer = "Player Two"
    
    @IBOutlet weak var playerOneLbl: UILabel!
    @IBOutlet weak var playerTwoLbl: UILabel!
    @IBOutlet weak var winLbl: UILabel!
    
    @IBOutlet weak var playerOneTxtField: UITextField!
    @IBOutlet weak var playerTwoTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        playerOneLbl.text = firstPlayer
        playerTwoLbl.text = secondPlayer
        if(winner != 0){
            //print(winner)
            if(winner == 1){
                winLbl.text = firstPlayer + " won!"
                winLbl.isHidden = false
            }else if(winner == 2){
                winLbl.text = secondPlayer + " won!"
                winLbl.isHidden = false
            }
            else if(winner == 3){
                winLbl.text = "Draw!"
                winLbl.isHidden = false
            }
        }
        
    }

    @IBAction func playBtn(_ sender: Any) {
        performSegue(withIdentifier: "toGame", sender: self)
    }
    @IBAction func playerOneName(_ sender: Any) {
        playerOneLbl.text = playerOneTxtField.text
    }
    
    @IBAction func playerTwoName(_ sender: Any) {
        playerTwoLbl.text = playerTwoTxtField.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! SecondViewController
        dest.playerOne = playerOneLbl.text!
        dest.playerTwo = playerTwoLbl.text!
    }
}

