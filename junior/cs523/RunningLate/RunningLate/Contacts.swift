//
//  Contacts.swift
//  RunningLate
//
//  Created by Chris Rudel on 4/10/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
//  The code will only use the first phone number in the persons contacts for each person
//  CS 523
//  Professor Damopolous
//  Running Late - Main.swift
//  I pledge my honor that I have abided by the Stevens Honor System - Christopher Rudel



import Foundation
import UIKit
import Contacts


class Contacts: UITableViewController, UINavigationControllerDelegate{
    
    var AvailContacts: [Person] = []
    var searchContacts: [Person] = []
    var searching = false

    @IBOutlet weak var searchBar: UISearchBar!
    
    private func getContacts(){
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                print("Failed to request access to contacts:", err)
                return
            }
            if granted{
                //print("Access granted")
                
                let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do{
                    try store.enumerateContacts(with: request, usingBlock:
                    {   (contact, stopEnumeration)  in
                        var name = ""
                        if(!contact.givenName.isEmpty){
                            name.append(contact.givenName + " ")
                        }
                        if(!contact.familyName.isEmpty){
                            name.append(contact.familyName)
                        }
                        
                        //print(type(of: contact.familyName))
                        
                        let phone:String = contact.phoneNumbers.first?.value.stringValue ?? ""
                        let dude = Person(name: name, phoneNumber: phone, selected: false)
                        self.AvailContacts.append(dude)
                        
                    })
                } catch let err{
                    print("failed to enumerate")
                    print(err)
                }

            }else{
                print("Access denied")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = self
        /* The below logic is saying if the contacts were already fetched, dont do it again */
        if(AvailContacts.count > 0){} else{
            getContacts()
        }
        //print(AvailContacts)
        super.viewDidAppear(true)
        self.tableView.reloadData()
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchContacts.count
        }else{
            return AvailContacts.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searching{
            cell.textLabel?.text = searchContacts[indexPath.row].name
            if(searchContacts[indexPath.row].selected){
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }
        }else{
            cell.textLabel?.text = AvailContacts[indexPath.row].name
            if(AvailContacts[indexPath.row].selected){
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }

        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching{
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                let name = tableView.cellForRow(at: indexPath)?.textLabel?.text
                for i in 0..<AvailContacts.count{
                    if(AvailContacts[i].name == name){
                        AvailContacts[i].selected = false
                    }
                }
            }else{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                let name = tableView.cellForRow(at: indexPath)?.textLabel?.text
                for i in 0..<AvailContacts.count{
                    if(AvailContacts[i].name == name){
                        AvailContacts[i].selected = true
                    }
                }
            }
        }else{
        
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
                AvailContacts[indexPath.row].selected = false
            }else{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
                AvailContacts[indexPath.row].selected = true
            }
        }
        //delegate?.userSelectedContacts(contacts: AvailContacts)
        //print(AvailContacts)
        //_ = self.navigationController?.popViewController(animated: true)
    }

    /*
    override func viewWillDisappear(_ animated: Bool) {
        print("d")
        delegate?.userSelectedContacts(contacts: AvailContacts)
        _ = self.navigationController?.popViewController(animated: true)
    }*/
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //print(AvailContacts)
        (viewController as? Main)?.AvailContacts = AvailContacts
    }
}

extension Contacts: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchContacts = AvailContacts.filter({$0.name.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        self.view.endEditing(true)
    }
}
