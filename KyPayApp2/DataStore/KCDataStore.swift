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
    
    func save <T:Encodable> (_ object : T , key : String){
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
             KeychainWrapper.standard.set(encoded, forKey: key)
        }
    }
    
    
    func load <T:Decodable> ( _ key : String, type : T.Type) -> T? {
        
        if let savedObject = KeychainWrapper.standard.data(forKey: key)  {
            let decoder = JSONDecoder()
            if let loadedObject = try? decoder.decode(type, from: savedObject) {
                        
                return loadedObject
            }
        }
        
        return nil
    }
    
    func remove(_ key : String){
        
        KeychainWrapper.standard.removeObject( forKey: key )
    }
    
}

extension KCDataStore {
    
    
    func saveUser( _ user : User ){
        
        save(user, key: KDS.userKey)
    }
    
    func getUser() -> User? {
        
        return load(KDS.userKey, type: User.self)
    }
    
    
    func removeUser(){
        
        remove(KDS.userKey)
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


extension KCDataStore {
    
    
    private static let lastKyPayUserSyncedKey = "keyPayUserSynced_ha5523fggFAf3"
    
    func saveLastKyPayUserSyncedDate(){
        
        let date = DateFormatter.string(from: Date())
        KeychainWrapper.standard.set(date, forKey: KDS.lastKyPayUserSyncedKey)
   
    }
    
    
    func lastSyncedDateLonger(than secs : TimeInterval = 3600) -> Bool{
        
        if let dateStr = KeychainWrapper.standard.string(forKey: KDS.lastKyPayUserSyncedKey){
       
           
            if let date = DateFormatter.date(from: dateStr){
                
                let dd = abs(date.timeIntervalSinceNow)
                //print("dd::\(dateStr)    \(dd)")
                return dd > secs
               
            }
            
        }
        
        return true
    }
    
    
   
}
