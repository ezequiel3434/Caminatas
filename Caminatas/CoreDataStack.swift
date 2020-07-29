//
//  CoreDataStack.swift
//  Caminatas
//
//  Created by Ezequiel Parada Beltran on 29/07/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName:String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores { (storesDescription, error) in
            if let error = error as NSError? {
                print("Ops, ocurrió un error: \(error.localizedDescription) ")
            }
        }
        
        return container
        
    }()
    
    
    private lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else {
            return
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            debugPrint("Ups, ocurrio algo: \(error.localizedDescription )")
        }
        
    }
    
}
