//
//  ViewController.swift
//  Cloud
//
//  Created by Chris Rudel on 4/29/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//

//  Christopher Rudel
//  CS 523
//  I pledge my honor that I have abided by the Stevens Honor System
//
//  I had trouble getting to show the notes in the tableView
//  the notes are appearing in the print area but they are not appearing in
//  the tableView. I looked over my code 4x and its the exact same as the
//  slides on canvas, I don't know why the data has trouble appearing in
//  the tableView. 


import UIKit
import CloudKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    let database = CKContainer.default().privateCloudDatabase
    var notes = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryDatabase), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        queryDatabase()
        self.tableView.reloadData()

    }
    
    @IBAction func onPlusTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Type Something", message: "What would you like to save in the note?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Type Note Here"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let post = UIAlertAction(title: "Post", style: .default) { (_) in
            guard let text = alert.textFields?.first?.text else {return}
            self.saveToCloud(note: text)
        }
        
        alert.addAction(cancel)
        alert.addAction(post)
        present(alert, animated: true, completion: nil)
    }
    
    func saveToCloud(note: String){
        let newNote = CKRecord(recordType: "Note")
        newNote.setValue(note, forKey: "content")
        database.save(newNote) { (record, error) in
            print(error ?? "")
            guard record != nil else {return}
            print(newNote)
            print("saved record")
        }
    }
    
    @objc func queryDatabase(){
        let query = CKQuery(recordType: "Note", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
            print(records)
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.notes = sortedRecords
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    


}
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let note = notes[indexPath.row].value(forKey: "content") as! String
        cell.textLabel?.text = note
        print(cell.textLabel?.text ?? "")
        print("alalalalalalalaalallalal")
        return cell
    }
}

