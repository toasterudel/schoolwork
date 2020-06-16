//
//  Messages.swift
//  RunningLate
//
//  Created by Chris Rudel on 4/28/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
//  CS 523
//  Professor Damopolous
//  Running Late - Main.swift
//  I pledge my honor that I have abided by the Stevens Honor System - Christopher Rudel

import Foundation
import UIKit
import MessageUI


class Messages: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    var AvailContacts: [Person] = []
    var ListContacts: [Person] = []
    var msg = ""
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var txtField: UITextField!
    @IBAction func txtFieldUpdate(_ sender: Any) {
        let text = txtField.text ?? ""
        lblText.text = text
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidAppear(true)
        if(msg == ""){}else{
            lblText.text = msg
        }
        for contact in AvailContacts{
            if contact.selected{
                ListContacts.append(contact)
            }
        }
        //print(AvailContacts.count)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel!.text = ListContacts[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? Main)?.MessageToSend = lblText.text ?? ""
    }
    
    
}
