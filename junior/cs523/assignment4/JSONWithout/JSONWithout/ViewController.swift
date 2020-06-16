//
//  ViewController.swift
//  JSON_and_Maps
//
//  Created by Chris Rudel on 3/3/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//

import UIKit
struct Superheros: Decodable{
    let heroName: String
    let name: String
}

class ViewController: UIViewController {
    
    var superheroArray = [Superheros]()
    let jsonDataURL = "http://patrickhill.nyc/justiceleague.json"
    

    @IBOutlet weak var superheroLabel: UILabel!
    @IBOutlet weak var secretIdentityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonFromURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getJsonFromURL(){
        let url = URL(string: jsonDataURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //should check error & check response status 200 ok
            do{
                self.superheroArray = try JSONDecoder().decode([Superheros].self, from: data!)
            }catch let jsonErr{
                print ("an error happened", jsonErr)
            }
            OperationQueue.main.addOperation({
                
                self.showNames()
            })
        }.resume()
    }
    
    func showNames(){
        for hero in superheroArray{
            superheroLabel.text = superheroLabel.text! + hero.heroName + "\n"
            secretIdentityLabel.text = secretIdentityLabel.text! + hero.name + "\n"
        }
    }


}

