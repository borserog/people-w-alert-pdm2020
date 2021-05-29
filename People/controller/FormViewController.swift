//
//  FormViewController.swift
//  People
//
//  Created by user198256 on 5/29/21.
//

import UIKit

class FormViewController: UIViewController {
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfAge: UITextField!
    var editablePerson: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if (self.editablePerson != nil) {
            self.tfNome.text = self.editablePerson.name
            self.tfAge.text = String(self.editablePerson.age)
        }
    }
    

    @IBAction func save(_ sender: Any) {
        let name = self.tfNome.text
        let age = Int16(self.tfAge.text!)
        
        if (self.editablePerson != nil) {
            self.editablePerson.name = name
            self.editablePerson.age = age!
            PersonDAO().update()
        } else {
            PersonDAO().add(name: name!, age: age!)        }
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
