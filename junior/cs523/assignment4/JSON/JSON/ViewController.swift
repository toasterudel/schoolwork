//
//  ViewController.swift
//  JSON
//
//  Created by Chris Rudel on 3/4/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var name = ""
    var heroName =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = "\(heroName)'s real name is \(name)"
    }


}

