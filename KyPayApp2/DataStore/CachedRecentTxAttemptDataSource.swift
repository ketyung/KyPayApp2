//
//  CachedRecentTxAttemptDataSource.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 28/06/2021.
//

import Foundation
import CoreData

typealias CRTADS = CachedRecentTxAttemptDataStore

class CachedRecentTxAttemptDataStore : NSObject {

    private var managedObjectContext : NSManagedObjectContext?
   
    init ( managedObjectContext : NSManagedObjectContext? = PC.shared.container.viewContext){
        
        super.init()
        
        if let managedObjectContext = managedObjectContext {
       
            self.managedObjectContext = managedObjectContext
        }
    }

    
    func saveAttempt(phoneNumber : String, name : String ){
        
        guard let managedObjectContext = self.managedObjectContext else { return }
        
        if let pm = self.getAttempt(by:phoneNumber)?.first {
        
            pm.name = name
            pm.lastUpdated = Date()
            
            do {
                try managedObjectContext.save()
            }
            catch{
                
                print("saving.err:\(error)")
            }
            
        }
        else {
            
            let pm = CachedRecentTxAttempt(context: managedObjectContext)
            
            pm.phoneNumber = phoneNumber
            pm.name = name
            pm.lastUpdated = Date()
            
            do {
                try managedObjectContext.save()
            }
            catch{
                
                print("saving.err:\(error)")
            }
      
        }
        
        
    }
}

extension CachedRecentTxAttemptDataStore {
    
    
    func getAttempt(by phoneNumber : String) -> [CachedRecentTxAttempt]?{
        
        guard let managedObjContext = self.managedObjectContext else { return nil }
      

        let myRequest : NSFetchRequest<CachedRecentTxAttempt> = CachedRecentTxAttempt.fetchRequest()
        
        let p0 = NSPredicate(format: "phoneNumber = %@", phoneNumber)
        
        myRequest.predicate = p0
        
        do{
            let results = try managedObjContext.fetch(myRequest)

            return results

        }
        catch let error{
            print(error)
            
            return nil
        }
    }
    
    
    func removeAttempt(by phoneNumber : String) {
        
        if let mObjContext = managedObjectContext {
        
            if let c = self.getAttempt(by: phoneNumber)?.first {
                
                mObjContext.delete(c)
                
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

extension CachedRecentTxAttemptDataStore {
    
    
    func total() -> Int{
        
        guard let managedObjContext = self.managedObjectContext else { return -1 }
      

        let myRequest : NSFetchRequest<CachedRecentTxAttempt> = CachedRecentTxAttempt.fetchRequest()
       
        
        do{
            let count = try managedObjContext.count(for: myRequest)

            return count

        }
        catch let error{
            
            print(error)
            
            return -1
        }
    }
    
    
    
    func recent(limit : Int = 20) -> [CachedRecentTxAttempt]?{
        
        guard let managedObjContext = self.managedObjectContext else { return nil }
      

        let myRequest : NSFetchRequest<CachedRecentTxAttempt> = CachedRecentTxAttempt.fetchRequest()
        
        myRequest.fetchLimit = limit
        let sort = NSSortDescriptor(key: #keyPath(CachedRecentTxAttempt.lastUpdated), ascending: false)
        myRequest.sortDescriptors = [sort]
        
        do{
            let results = try managedObjContext.fetch(myRequest)

            return results

        }
        catch let error{
            print(error)
            
            return nil
        }
    }
}
