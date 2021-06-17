//
//  PersistenceController.swift
//  SwiftUICoreDataMVVM
//
//  Created by Chee Ket Yung on 12/02/2021.
//

import CoreData

typealias PC = PersistenceController

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    init(){
        
        container = NSPersistentContainer(name: "KyPayDb")
        
        container.loadPersistentStores {
            (storeDescription, error) in
            
            if let err = error {
                
                fatalError("fatalError : \(err.localizedDescription)")
            }
            
        }
        
    }
}
