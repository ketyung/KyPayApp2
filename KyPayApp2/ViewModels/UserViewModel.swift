//
//  UserViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import Foundation
import FirebaseAuth

private struct UserHolder {
    
    var user : User = User()
}


class UserViewModel : NSObject, ObservableObject {
    
    @Published private var userHolder = UserHolder()
    
    var id : String {
        
        get {
            
            userHolder.user.id ?? ""
        }
        
        set(newVal){
            
            userHolder.user.id = newVal
        }
    }
    
    var firstName : String {
        
        get {
            
            userHolder.user.firstName ?? ""
        }
        
        set(newVal){
            
            userHolder.user.firstName = newVal
        }
    }
    
    
    var lastName : String {
        
        
        get {
            
            userHolder.user.lastName ?? ""
        }
        
        set(newVal){
            
            userHolder.user.lastName = newVal
        }
    }
    
    
    var email : String {
        
        get {
            
            userHolder.user.email ?? ""
        }
        
        set(newVal){
            
            userHolder.user.email = newVal
        }
    }
    
    
    var dob : Date {
        
        get {
            
            userHolder.user.dob ?? Date()
        }
        
        set(newVal){
            
            userHolder.user.dob = newVal
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


extension UserViewModel {
    
    
    func signIn (verificationCode : String, completion : ((Bool,Error?)->Void)? = nil  ){
        
        PA.shared.signIn(verificationCode: verificationCode, completion: {
            phoneNumber, err in
            
            if let err = err {
                
                completion?(false, err)
                return
            }
            
            
            if let phone = phoneNumber {
           
                
                ARH.shared.fetchUser(phoneNumber: phone, completion: {
                    
                    res in
                    
                    switch (res) {
                    
                        case .failure(let err) :
                            if let err = err as? ApiError, err.statusCode == 404 {
                                // indicate first sign in if NOT found!
                                completion?(true, nil)
                                
                            }
                            else {
                            
        
                                completion?(false, err)
                            }
                            
                        case .success(let rr) :
                            
                            // save the user info
                            KDS.shared.saveUser(rr)
                            
                            self.userHolder.user = rr 
                            
                            completion?(false, nil)
                            
                    }
                    
                })
               
            }
            
        })
    }
}
