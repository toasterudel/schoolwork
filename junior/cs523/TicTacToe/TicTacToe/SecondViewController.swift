//
//  SecondViewController.swift
//  TicTacToe
//
//  Created by Chris Rudel on 3/17/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
//  CS 523
//  I pledge my honor that I have abided by the Stevens Honor System

import UIKit

class SecondViewController: UIViewController{
    
    var player = 1
    var playerOne = ""
    var playerTwo = ""
    var boardstate = [10,11,12,13,14,15,16,17,18]
    var boardpressed = [false,false,false,false,false,false,false,false,false]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //This function applies to all the buttons in the second view controller
    @IBAction func pressedBtn(_ sender: Any) {
    
        //sender is the button that sent the action 
        let tag = (sender as AnyObject).tag!
        if(boardstate[tag] >= 10){
            
            boardstate[tag] = player
            boardpressed[tag] = true

            //print(boardstate)
            
            if(player == 1){    //this is assuming player 1 is o and player 2 is x
                (sender as AnyObject).setImage(UIImage(named: "oimage.png"), for: UIControl.State())
                player = 2
                
            }else{
                (sender as AnyObject).setImage(UIImage(named: "ximage.png"), for: UIControl.State())
                player = 1
            }
        }
        if(checkWinConditions()){
            if(player == 1){
                player = 2
            }else{
                player = 1
            }
            performSegue(withIdentifier: "toWinScreen", sender: self)
        }
        
        if(checkDraw()){
            player = 3
            performSegue(withIdentifier: "toWinScreen", sender: self)
            
        }
    }
    
    func checkWinConditions() -> Bool{
        var win = false
        //check top across
        if(boardstate[0] == boardstate[1] && boardstate[1] == boardstate[2] && boardstate[0] == boardstate[2]){
            win = true
            
        }
        
        //check middle across
        if(boardstate[3] == boardstate[4] && boardstate[4] == boardstate[5] && boardstate[3] == boardstate[5]){
            win = true

        }
        
        //check bottom across
        if(boardstate[6] == boardstate[7] && boardstate[7] == boardstate[8] && boardstate[6] == boardstate[8]){
            win = true

        }
        
        //check left down
        if(boardstate[0] == boardstate[3] && boardstate[0] == boardstate[6] && boardstate[3] == boardstate[6]){
            win = true

        }
        
        //check middle down
        if(boardstate[1] == boardstate[4] && boardstate[4] == boardstate[7] && boardstate[1] == boardstate[7]){
            win = true

        }
        
        //check right down
        if(boardstate[2] == boardstate[5] && boardstate[5] == boardstate[8] && boardstate[2] == boardstate[8]){
            win = true

        }
        
        //check diagonal down right
        if(boardstate[0] == boardstate[4] && boardstate[4] == boardstate[8] && boardstate[0] == boardstate[8]){
            win = true

        }

        //check diagonal down left
        if(boardstate[2] == boardstate[4] && boardstate[4] == boardstate[6] && boardstate[2] == boardstate[6]){
            win = true

        }
        return win
    }
    
    func checkDraw() -> Bool{
        var tie = true
        for element in boardpressed{
            if(element == false){
                tie = false
            }
        }
        return tie
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print(player)
        let dest = segue.destination as! ViewController
        dest.winner = player
        dest.firstPlayer = playerOne
        dest.secondPlayer = playerTwo
    }
}
