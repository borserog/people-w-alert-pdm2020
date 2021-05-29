//
//  TableViewController.swift
//  People
//
//  Created by user198256 on 5/29/21.
//

import UIKit

class TableViewController: UITableViewController {
    var people: Array<Person>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.people = PersonDAO().get()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.people = PersonDAO().get()
        self.tableView.reloadData()
    }
    
    @IBAction func filter(_ sender: Any) {
        let input = UIAlertController(title: "Filtro", message: "Filtrar pelo nome da pessoa", preferredStyle:  UIAlertController.Style.alert)
        	
        input.addTextField { textField in
            textField.placeholder = "Informe uma pessoa"
        }
        
        input.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alertAction in
            self.people = PersonDAO().get().filter { person in
                return person.name == input.textFields![0].text!
            }
            self.tableView.reloadData()
        }))
        
        input.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel))
        
        input.addAction(UIAlertAction(title: "Exibir todas", style: UIAlertAction.Style.default, handler: { alertAction in
            self.people = PersonDAO().get()
            self.tableView.reloadData()
        }))
        
        
        self.present(input, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "person", for: indexPath)

        let person = self.people[indexPath.row]
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = String(person.age)

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = self.people[indexPath.row]
            PersonDAO().del(person: person)
            self.people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fvc = self.storyboard?.instantiateViewController(identifier: "form") as! FormViewController
        fvc.editablePerson = self.people[indexPath.row]
        self.navigationController?.pushViewController(fvc, animated: true)
    }

}
