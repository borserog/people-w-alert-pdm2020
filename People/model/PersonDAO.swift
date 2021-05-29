//
//  PersonDAO.swift
//  People
//
//  Created by user198256 on 5/29/21.
//

import Foundation
import UIKit
import CoreData

class PersonDAO {
    var delegate: AppDelegate!
    
    init() {
        self.delegate = (UIApplication.shared.delegate as! AppDelegate)
    }
    
    func add(name: String, age: Int16) {
        let person = Person(context: self.delegate.persistentContainer.viewContext)
        person.name = name
        person.age = age
        self.delegate.saveContext()
    }
    
    func get() -> Array<Person> {
        // filtering follows this logic
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let people = try self.delegate.persistentContainer.viewContext.fetch(request)
            return people
        } catch {
            return Array<Person>()
        }
    }
    
    func del(person: Person) {
        self.delegate.persistentContainer.viewContext.delete(person)
        self.delegate.saveContext()
    }
    
    func update() {
        self.delegate.saveContext()
    }
    
}
