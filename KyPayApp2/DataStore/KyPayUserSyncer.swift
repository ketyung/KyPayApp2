//
//  KyPayUserSyncer.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import Foundation

class KyPayUserSyncer : NSObject {
    
    private let dataStore = KyPayContactDataStore()
    
    
    func syncNow( completion : ((String?)->Void)? = nil ) {
        
       /**
          Use this in iOS 15 only, sick!!!!
        await withThrowingTaskGroup (of : [Contact].self) { group in
        }*/
        
        let contacts = ContactFetcher.getContacts()
        
        var i = 0
        contacts.forEach{ contact in
            
            self.fetchAndSaveContactIfNotPresent(contact, completion: { succ in
                
                if succ {
                    i += 1
                }
                
            })
        }
        
            
        KDS.shared.saveLastKyPayUserSyncedDate()
        
        completion?("\(i) \("number of contact(s) synced!".localized)")
    }
    
}

extension KyPayUserSyncer {
    
    private func fetchAndSaveContactIfNotPresent( _ contact : Contact,
    completion : ((Bool)->Void)? = nil  ){
        
        guard let _ = dataStore.getKyPayUser(by: contact.cnIdentifier)?.first else {
            
            
            print("fetching.phone::\(contact.phoneNumber)")
            ARH.shared.fetchUser(phoneNumber: contact.phoneNumber, completion: { [weak self]
                
                res in
                
                guard let sself = self else {
                    
                    print("self.nil!!")
                    return
                }
                
                switch(res) {
               
                    case .failure(let err) :
                        print("failed::.err:\(err)")
                        completion?(false)
                    
                    case .success(let user) :
                        
                        print("user.phone::\(user.phoneNumber ?? "")")
                       
                        if user.phoneNumber == contact.phoneNumber {
                            
                            sself.dataStore.saveKyPayUser(by: contact)
                            
                            print("saved.phone::\(contact.phoneNumber)")
                           
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
