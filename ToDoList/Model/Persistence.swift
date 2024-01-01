//
//  Persistence.swift
//  ToDoList
//
//  Created by Aman Gupta on 01/01/24.
//

import Foundation
import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name:"ToDoList")
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath:"/dev/null")
            
        }
        container.loadPersistentStores(completionHandler:{(storeDescription,error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
}


static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    
    for index in 0..<10 {
        let newItem = ToDoItem(context: viewContext)
        newItem.id = UUID()
        newItem.name = "To do the item #\(index)"
        newItem.priority = .normal
        newItem.isComplete = false
    }
    
    do{
        try viewContext.save()
        
    }
    catch{
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
    
}()
