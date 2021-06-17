//
//  KyPayUserSyncer.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import Foundation

class KyPayUserSyncer : NSObject {
    
    private let dataStore = KyPayContactDataStore()
    
    
    func syncNow(_ contacts : [Contact], completion : ((String?)->Void)? = nil ) {
        
       /**
          Use this in iOS 15 only, sick!!!!
        await withThrowingTaskGroup (of : [Contact].self) { group in
        }*/
        
        var i = 0
        contacts.forEach{ contact in
            
            self.fetchAndSaveContactIfNotPresent(contact, completion: { succ in
                
                if succ {
                    i += 1
                }
                
            })
        }
        
        if ( i > 0 ){
            
            KDS.shared.saveLastKyPayUserSyncedDate()
        }
        
        completion?("\(i) \("number of contact(s) synced!".localized)")
    }
    
}

extension KyPayUserSyncer {
    
    private func fetchAndSaveContactIfNotPresent( _ contact : Contact,
    completion : ((Bool)->Void)? = nil  ){
        
        guard let _ = dataStore.getKyPayUser(by: contact.cnIdentifier)?.first else {
            
            ARH.shared.fetchUser(phoneNumber: contact.phoneNumber, completion: { [weak self]
                
                res in
                
                guard let self = self else {
                    return
                }
                
                switch(res) {
               
                    case .failure(let err) :
                        print("failed::.err:\(err)")
                        completion?(false)
                    
                    case .success(let user) :
                        if user.phoneNumber == contact.phoneNumber {
                            
                            self.dataStore.saveKyPayUser(by: contact)
                            completion?(true)
                        }
                        else {
                            
                            completion?(false)
                        }
                }
               
                
            })
            
            return
        }

    }
}
