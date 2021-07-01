//
//  KyPayContactDataStore.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import Foundation
import CoreData

typealias KCDS = KyPayContactDataStore 

class KyPayContactDataStore : NSObject {

    private var managedObjectContext : NSManagedObjectContext?
   
    init ( managedObjectContext : NSManagedObjectContext? = PC.shared.container.viewContext){
        
        super.init()
        
        if let managedObjectContext = managedObjectContext {
       
            self.managedObjectContext = managedObjectContext
        }
    }

    
    func saveKyPayUser(by contact : Contact ){
        
        guard let managedObjectContext = self.managedObjectContext else { return }
        
        if let kcontact = self.getKyPayUser(by: contact.cnIdentifier)?.first {
        
            kcontact.firstName = contact.firstName
            kcontact.lastName = contact.lastName
            kcontact.phoneNumber = contact.phoneNumber
            kcontact.lastUpdated = Date()
            
            do {
                try managedObjectContext.save()
            }
            catch{
                
                print("saving.err:\(error)")
            }
            
        }
        else {
            
            let kcontact = KyPayUser(context: managedObjectContext)
            kcontact.firstName = contact.firstName
            kcontact.lastName = contact.lastName
            kcontact.phoneNumber = contact.phoneNumber
            kcontact.cnIdentifier = contact.cnIdentifier
            kcontact.lastUpdated = Date()
            
            do {
                try managedObjectContext.save()
            }
            catch{
                
                print("saving.err:\(error)")
            }
      
        }
        
        
    }
}

extension KyPayContactDataStore {
    
    
    func getKyPayUser(by cnIdentifier : String) -> [KyPayUser]?{
        
        guard let managedObjContext = self.managedObjectContext else { return nil }
      

        let myRequest : NSFetchRequest<KyPayUser> = KyPayUser.fetchRequest()
        
        myRequest.predicate = NSPredicate(format: "cnIdentifier = %@", cnIdentifier)

        do{
            let results = try managedObjContext.fetch(myRequest)

            return results

        }
        catch let error{
            print(error)
            
            return nil
        }
    }
    
    
    func removeKyPayUser(by cnIdentifier : String) {
        
        if let mObjContext = managedObjectContext {
        
            if let usr = self.getKyPayUser(by: cnIdentifier)?.first {
                
                mObjContext.delete(usr)
                
                do {
                    try mObjContext.save()
                }
                catch {
                    print("Failed to delete!!!")
                }
            }
        }
    }
}

extension KyPayContactDataStore {
    
    
    func total() -> Int{
        
        guard let managedObjContext = self.managedObjectContext else { return -1 }
      

        let myRequest : NSFetchRequest<KyPayUser> = KyPayUser.fetchRequest()
        
       
        do{
            let count = try managedObjContext.count(for: myRequest)

            return count

        }
        catch let error{
            
            print(error)
            
            return -1
        }
    }
    
    
    
    func all() -> [KyPayUser]?{
        
        guard let managedObjContext = self.managedObjectContext else { return nil }
      

        let myRequest : NSFetchRequest<KyPayUser> = KyPayUser.fetchRequest()
        
        do{
            let results = try managedObjContext.fetch(myRequest)

            return results

        }
        catch let error{
            print(error)
            
            return nil
        }
    }
    
    func removeAll() {
        
        if let allRes = all() {
        
            allRes.forEach{ c in
                
                removeKyPayUser(by: c.cnIdentifier ?? "")
                
            }
        }
        
    }
    
    
}
