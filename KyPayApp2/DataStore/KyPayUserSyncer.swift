//
//  KyPayUserSyncer.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import Foundation

class KyPayUserSyncer : NSObject {
    
    private let dataStore = KyPayContactDataStore()
    
    
    func syncNow( removeAllFirst : Bool = false, completion : ((String?)->Void)? = nil ) {
        
       /**
          Use this in iOS 15 only, sick!!!!
        await withThrowingTaskGroup (of : [Contact].self) { group in
        }*/
        
        if removeAllFirst {
            
            self.dataStore.removeAll()
        }
        
        
        let contacts = ContactFetcher.getContacts()
        
        contacts.forEach{ contact in
            
            self.fetchAndSaveContactIfNotPresent(contact, completion: { succ in
                
                print("saved.contact::\(contact.firstName):\(succ)")
                
            })
        }
        
            
        KDS.shared.saveLastKyPayUserSyncedDate()
        
        completion?("contacts synced!".localized)
        
        //print("total::\(dataStore.total())")
    }
    
}

extension KyPayUserSyncer {
    
    private func fetchAndSaveContactIfNotPresent( _ contact : Contact,
    completion : ((Bool)->Void)? = nil  ){
        
        guard let _ = dataStore.getKyPayUser(by: contact.cnIdentifier)?.first else {
            
            
            //print("fetching.phone::\(contact.phoneNumber)")
            ARH.shared.fetchUser(phoneNumber: contact.phoneNumber, completion: { [weak self]
                
                res in
                
                guard let self = self else {return}
                
                switch(res) {
               
                    case .failure(_) :
                       // print("failed::.err:\(err)")
                        completion?(false)
                    
                    case .success(let user) :
                        
                       
                        if user.phoneNumber == contact.phoneNumber {
                          
                            DispatchQueue.main.async {
                         
                                self.dataStore.saveKyPayUser(by: contact)
                            }
                            
                            completion?(true)
                        }
                        else {
                            
                            completion?(false)
                        }
                }
               
                
            })
            
            return
        }
        
        completion?(false)
 

    }
}
