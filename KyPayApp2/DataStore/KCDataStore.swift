//
//  KCDataStore.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import SwiftKeychainWrapper

typealias KDS = KCDataStore

class KCDataStore : NSObject {
    
    
    private static let userKey : String = "User_982737baba366363BAGh3l883_lo"
    
    static let shared = KDS()
    
    func saveUser( _ user : User ){
        
       let encoder = JSONEncoder()
       if let encoded = try? encoder.encode(user) {
            KeychainWrapper.standard.set(encoded, forKey: KDS.userKey)
       }
    }
    
    func getUser() -> User? {
        
        if let savedUser = KeychainWrapper.standard.data(forKey: KDS.userKey)  {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                        
                return loadedUser
            }
        }
        
        return nil
    }
    
    
    func removeUser(){
        
        KeychainWrapper.standard.removeObject(forKey: KDS.userKey)
    }
    
}

extension KCDataStore {
    
    private static let fbVerificationIDKey = "FbVerID_8736363bVZAv3t36VAV39NBgad_09OP"
    
    func saveFBVid( _ id : String ){
        
        KeychainWrapper.standard.set(id, forKey: KDS.fbVerificationIDKey)
    }
    
    
    func getFBVid() -> String?{
        
        return KeychainWrapper.standard.string(forKey: KDS.fbVerificationIDKey)
        
    }
    
    
    func removeFBVid(){
        
        KeychainWrapper.standard.removeObject(forKey: KDS.fbVerificationIDKey)
    }
    
}
