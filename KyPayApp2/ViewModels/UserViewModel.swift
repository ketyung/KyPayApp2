//
//  UserViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import Foundation
import FirebaseAuth

private struct UserHolder {
    
    var user : User = loadUser()
    
    private static func loadUser() -> User{
        
        if let u = KDS.shared.getUser() {
            
            return u
        }
        
        return User()
    }
}


class UserViewModel : NSObject, ObservableObject {
    
    @Published private var userHolder = UserHolder()
    
    @Published var firstSignIn : Bool = false
    
    @Published var showingProgressIndicator : Bool = false
    
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
    
    
    var phoneNumber : String {
        
        get {
            
            userHolder.user.phoneNumber ?? ""
        }
        
        set(newVal){
            
            userHolder.user.phoneNumber = newVal
        }
    }
    
    var phoneNumberOnly : String {
        
        get {
            
            Country.phoneNumberOnly(phoneNumber, countryCode: userHolder.user.countryCode ?? Common.defaultCountry)
        }
        
        set(newVal){
            
            phoneNumber = newVal
        }
    }
    
    var accountType : User.AccountType {
        
        get {
            
            userHolder.user.accountType ?? .personal
        }
        
        set(newVal){
            
            userHolder.user.accountType = newVal
        }
        
    }
    
    
    var isBusinessUser : Bool {
        
        accountType == .business
    }
    
    
    var countryCode : String {
        
        get {
            
            userHolder.user.countryCode ?? Common.defaultCountry
        }
        
        set(newVal){
            
            userHolder.user.countryCode = newVal
        }
    }
    
    var hasSignedIn : Bool {
        
    
        if let auser = Auth.auth().currentUser  {
    
            if firstSignIn {
                
                return firstSignIn
            }
          
            
            if let user = KDS.shared.getUser() {
                
                return auser.phoneNumber == user.phoneNumber
            }
            
        }
        
        return false
   
    }
    
    var user : User{
        
        userHolder.user
    }
    
    
    private var currency : String?
    
    
    var allowedCurrency : String {
        
        guard let currency = self.currency else {
            
            self.currency = CurrencyManager.currency(countryCode: user.countryCode ?? "")
            return self.currency ?? ""
        }
        
        return currency
    }
    
}

extension UserViewModel {
   
    func loadUser(_ user : User) {
        
        self.userHolder.user = user 
    }
}

extension UserViewModel {
    
    private func removeAllStored(){
        
        WalletHandler().detachWallet()
    
        CPMDS().removeAll()
        CRTADS().removeAll()
        KCDS().removeAll()
        KDS.shared.removeUser()
        KDS.shared.removeAllWallets()
       
    }
    
    
    func signOut(completion : ((Error?)-> Void)? = nil ){
        
        do {
       
            try Auth.auth().signOut()
    
            removeAllStored()
            
            DispatchQueue.main.async {
                
                self.userHolder.user = User()
            }
            
            completion?(nil)
        }
        catch {
            
            completion?(error)
            
        }
    }
}


extension UserViewModel {
    
    
    func signIn (verificationCode : String, completion : ((Bool,Error?)->Void)? = nil  ){
        
        PA.shared.signIn(verificationCode: verificationCode, completion: { phoneNumber, err in
    
            
            if let err = err {
                completion?(false, err)
                return
            }
            
            
            if let phone = phoneNumber {
           
                
                ARH.shared.fetchUser(phoneNumber: phone, completion: {  [weak self]
                    
                    res in
                    
                    
                    guard let self = self else {
                        return
                    }
               
                    
                    switch (res) {
                    
                        case .failure(let err) :
                            if let err = err as? ApiError, err.statusCode == 404 {
                                // indicate first sign in if NOT found!
                                // save the phone number to userViewModel
                                
                                DispatchQueue.main.async {
                                    
                                    self.phoneNumber = phone
                                }
                                
                                completion?(true, nil)
                                
                            }
                            else {
                                completion?(false, err)
                            }
                            
                        case .success(let usr) :
                            
                            // save the user info
                            KDS.shared.saveUser(usr)
                            
                            // refresh user in userHolder
                            DispatchQueue.main.async {
                           
                                self.userHolder.user = usr
                            }
                            
                            completion?(false, nil)
                            
                    }
                    
                })
               
            }
            
        })
    }
}

extension UserViewModel {
    
    struct FirstSignInError : LocalizedError, CustomStringConvertible {
       
        var description: String {
            
            errorText ?? ""
        }
    
        var errorText : String?
        
        public var errorDescription : String {
            
            errorText ?? ""
        }
        
    }
    
    
    
    
    func add(country : Country?, completion : ((Error?)-> Void)? = nil ){
        
        
        guard let country = country else {
            
            completion?(FirstSignInError(errorText: "No selected country".localized))
            self.showingProgressIndicator = false
            return
        }
        
        self.countryCode = country.code ?? Common.defaultCountry
    
        
        self.showingProgressIndicator = true
        
        if !self.phoneNumber.isValidPhone() {
   
            completion?(FirstSignInError(errorText: "Invalid phone number!".localized))
            self.showingProgressIndicator = false
            return
   
        }
        
        
        if self.firstName.trim().isEmpty {
    
            completion?(FirstSignInError(errorText: "First Name is blank!".localized))
            self.showingProgressIndicator = false
            return
            
        }
      
        
        if self.lastName.trim().isEmpty {
    
            completion?(FirstSignInError(errorText: "Last Name is blank!".localized))
            self.showingProgressIndicator = false
            return
            
        }
    
        if !self.email.isValidEmail() {
    
            completion?(FirstSignInError(errorText: "Invalid email!".localized))
            self.showingProgressIndicator = false
            return
            
        }
    
        if !self.dob.isMoreThan(years: 12){
            
            completion?(FirstSignInError(errorText: "You must be 12yo & above!".localized))
            self.showingProgressIndicator = false
            return
        }
        
        
        ARH.shared.addUser(user, returnType: User.self, completion: { [weak self]
        
            res in
        
            guard let self = self else {return}
            
            switch(res) {
     
                case .failure(let err) :
                
                    completion?(err)
                
                case .success(let usr ) :
                
                
                    if let ruser = usr.returnedObject {
                   
                        KDS.shared.saveUser(ruser)
                        
                        // refresh user in userHolder
                        DispatchQueue.main.async {
                       
                            self.userHolder.user = ruser
                        }
                        
                        self.firstSignIn = false
                       
                    }
                   
                    
                    completion?(nil)
                
            }
            
            DispatchQueue.main.async {
         
                self.showingProgressIndicator = false
            }
           
            
        })
    }
}

extension UserViewModel {
    
    
    func updateDeviceTokenRemotely (_ token : String){
        
        let dt = DeviceToken(id: self.id, token: token)
        ARH.shared.saveDeviceToken(dt,returnType:DeviceToken.self ,  completion: {
            
            res  in
            
            switch (res) {
                
                case .failure(let err) :
                    print("err:\(err)")
            
                case .success(let succ) :
                    print("succ::\(String(describing: succ.returnedObject))")
            }
            
        })

    }
}
