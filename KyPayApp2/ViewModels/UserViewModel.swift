//
//  UserViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import Foundation
import FirebaseAuth

class UserViewModel : NSObject, ObservableObject {
    
    @Published private var user = loadUser()
    
    var id : String {
        
        get {
            
            user.id ?? ""
        }
        
        set(newVal){
            
            user.id = newVal
        }
    }
    
    var firstName : String {
        
        get {
            
            user.firstName ?? ""
        }
        
        set(newVal){
            
            user.firstName = newVal
        }
    }
    
    
    var lastName : String {
        
        
        get {
            
            user.lastName ?? ""
        }
        
        set(newVal){
            
            user.lastName = newVal
        }
    }
    
    
    var email : String {
        
        get {
            
            user.email ?? ""
        }
        
        set(newVal){
            
            user.email = newVal
        }
    }
    
    
    var dob : Date {
        
        get {
            
            user.dob ?? Date()
        }
        
        set(newVal){
            
            user.dob = newVal
        }
    }
    
    var hasSignedIn : Bool {
        
       
        if let user = KDS.shared.getUser() , let auser = Auth.auth().currentUser {
            
            return auser.phoneNumber == user.phoneNumber
        }
     
        return false
   
    }
    
}

extension UserViewModel {
   
    
    private static func loadUser() -> User{
        
        if let u = KDS.shared.getUser() {
            
            return u
        }
        
        return User()
    }
}

extension UserViewModel {
    
    
    func signOut(completion : ((Error?)-> Void)? = nil ){
        
        do {
       
            try Auth.auth().signOut()
    
            KDS.shared.removeUser()
            
            completion?(nil)
        }
        catch {
            
            completion?(error)
            
        }
    }
}

