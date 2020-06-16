//
//  TableViewController.swift
//  JSON
//
//  Created by Chris Rudel on 3/4/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
struct Superheros: Decodable{
    let heroName: String
    let name: String
}
import UIKit

class TableViewController: UITableViewController {

    
    var superheroArray = [Superheros]()
    var currentItem_heroName = ""
    var currentItem_name = ""
    let jsonDataURL = "http://patrickhill.nyc/justiceleague.json"
    
    override func viewDidLoad() {
        superheroArray.append((Superheros(heroName: "Spider-man", name: "Peter Parker")))
        getJsonFromURL()
        sleep(1)    // without this line the view controller loads before all the heros are loaded
                    // so the number of rows in the table will be 0, showing nothing
        super.viewDidLoad()


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return superheroArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = superheroArray[indexPath.row].heroName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentItem_name = superheroArray[indexPath.row].name
        currentItem_heroName = superheroArray[indexPath.row].heroName
        performSegue(withIdentifier: "showDetail", sender: nil)
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
//            OperationQueue.main.addOperation({
//                showNames()
//            })
            }.resume()
    }

 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController{
            viewController.heroName = currentItem_heroName
            viewController.name = currentItem_name
        }
    }
    

}
