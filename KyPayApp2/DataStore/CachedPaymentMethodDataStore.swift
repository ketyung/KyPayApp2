//
//  CachedPaymentMethodDataStore.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 25/06/2021.
//


import Foundation
import CoreData

typealias CPMDS = CachedPaymentMethodDataStore


class CachedPaymentMethodDataStore : NSObject {

    private var managedObjectContext : NSManagedObjectContext?
   
    init ( managedObjectContext : NSManagedObjectContext? = PC.shared.container.viewContext){
        
        super.init()
        
        if let managedObjectContext = managedObjectContext {
       
            self.managedObjectContext = managedObjectContext
        }
    }

    
    func savePaymentMethod(by paymentMethod : PaymentMethod ){
        
        guard let managedObjectContext = self.managedObjectContext else { return }
        
        if let pm = self.getPaymentMethod(by: paymentMethod.country ?? Common.defaultCountry, type: paymentMethod.type ?? "")?.first {
        
            pm.type = paymentMethod.type
            pm.imageURL = paymentMethod.imageURL?.absoluteString
            pm.category = paymentMethod.category
            pm.country = paymentMethod.country
            pm.paymentFlowType = paymentMethod.paymentFlowType
            pm.name = paymentMethod.name
            pm.lastUpdated = Date()
            
            do {
                try managedObjectContext.save()
            }
            catch{
                
                print("saving.err:\(error)")
            }
            
        }
        else {
            
            let pm = CachedPaymentMethod(context: managedObjectContext)
            
            pm.type = paymentMethod.type
            pm.imageURL = paymentMethod.imageURL?.absoluteString
            pm.category = paymentMethod.category
            pm.country = paymentMethod.country
            pm.paymentFlowType = paymentMethod.paymentFlowType
            pm.name = paymentMethod.name
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

extension CachedPaymentMethodDataStore {
    
    
    func getPaymentMethod(by country : String, type : String) -> [CachedPaymentMethod]?{
        
        guard let managedObjContext = self.managedObjectContext else { return nil }
      

        let myRequest : NSFetchRequest<CachedPaymentMethod> = CachedPaymentMethod.fetchRequest()
        
        let p0 = NSPredicate(format: "country = %@", country)
        let p1 = NSPredicate(format: "type = %@", type)

        myRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p0, p1])

        do{
            let results = try managedObjContext.fetch(myRequest)

            return results

        }
        catch let error{
            print(error)
            
            return nil
        }
    }
    
    
    func removePaymentMethod(by country : String, type : String) {
        
        if let mObjContext = managedObjectContext {
        
            if let c = self.getPaymentMethod(by: country, type: type)?.first {
                
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

extension CachedPaymentMethodDataStore {
    
    
    func total(by country : String? = nil) -> Int{
        
        guard let managedObjContext = self.managedObjectContext else { return -1 }
      

        let myRequest : NSFetchRequest<CachedPaymentMethod> = CachedPaymentMethod.fetchRequest()
        
        if let country = country {
            
            myRequest.predicate = NSPredicate(format: "country = %@", country)
        }
      
        
        do{
            let count = try managedObjContext.count(for: myRequest)

            return count

        }
        catch let error{
            
            print(error)
            
            return -1
        }
    }
    
    
    
    func all(by country : String? = nil) -> [CachedPaymentMethod]?{
        
        guard let managedObjContext = self.managedObjectContext else { return nil }
      

        let myRequest : NSFetchRequest<CachedPaymentMethod> = CachedPaymentMethod.fetchRequest()
        
        if let country = country {
            
            myRequest.predicate = NSPredicate(format: "country = %@", country)
        }
        
        do{
            let results = try managedObjContext.fetch(myRequest)

          //  print("locally.stored.cpms.count::\(results.count)")
            return results

        }
        catch let error{
            print(error)
            
            return nil
        }
    }
    
    
    func removeAll(){
        
        
        if let allRes = all() {
        
            allRes.forEach{ c in
                
                removePaymentMethod(by: c.country ?? "", type: c.type ?? "")
            }
        }
      
    }
}
