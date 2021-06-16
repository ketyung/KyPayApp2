//
//  Tester.swift
//  KyPayApiTester
//
//  Created by Chee Ket Yung on 09/06/2021.
//

import Foundation
import UIKit



struct TestData2 : Codable {
    
    var code : String?
}

struct TestData <U:Codable> : Codable {
    
    var id : String?
    
    var text : String?
    
    var more : U?
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case more
    }
   
    init(from decoder: Decoder) throws {

        try self.init(from: decoder, moreType: [TestData2].self as! U.Type )
    }
    
    
    init(from decoder: Decoder, moreType : U.Type ) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
        more = try values.decode(moreType, forKey:.more)
    }
}

class Tester {
    
    /**
    static func testJson(){
        
        let t = Bundle.main.decodeJson(TestData.self,
                                       returnType: [TestData2].self,
                                       fileName: "T.json")
        
        print("t.id::\(t.id ?? "")::t.text ::\(t.text ?? ""):: more::\(String(describing: t.more))")
    }
     */
    
    
    static func testPhoneAuth(phone : String = "+60168319183"){
        
        PA.shared.sendOTP(phoneNumber: phone)
    }
    
    
    static func testStoreAndRetrieveUser(){
        
        let u = User(id: "88373737agsvd", firstName: "Chee", lastName: "K Y")
        KDS.shared.saveUser( u )
        
        if let uu = KDS.shared.getUser() {
            
            print("Loaded::.user::\(uu.id ?? "")::\(uu.firstName ?? "")")
        }
        
    }
    
    
    static func testDecodeCountries(){
        
        let countries = Bundle.main.decodeJson([Country].self, fileName: "CountryPickerView.bundle/Data/CountryCodes.json")
        
        countries.forEach{
            
            country in
            
            print("\(country.code ?? "") :: \(country.dialCode ?? "")")
        }
    }
    
    
    static func testx <T:Decodable, U:Codable>( type : T, returnValue : U, completion : ((U)->Void)? = nil ) {
    
    
        if let com = completion {
            
            com(returnValue)
        }
    }
    
    static func testyy(){
        
        Tester.testx(type: User(), returnValue: User(), completion: {
            
            res in
            
            
        })
    }
    
    
     static func testSignOut(){
        
        let u = User(id:"Key_2QNU8IzG")
        
        ARH.shared.signOutUser(u,
                               returnType: User.self,
                               completion: {
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error.xx:\(err)")
                case .success(let rr) :
                    print("rr.id::.signOut::\(String(describing: rr.id))")
            }
        })
        
    }

    
    static func testSignIn(phoneNumber : String = "+60138634848"){
        
        
        //fetchUser(id: "Key_2QNU8IzG")
        
       // fetchUser(id: "Van_YE9EWOtl")
 
        //fetchUser(id: "Yon_BTIUoIef")
        
        ARH.shared.signInUser(phoneNumber:  phoneNumber ,
                              returnType: User.self,
                              completion: {
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("errorx..!:\(err)")
                case .success(let rr) :
                    
                    if rr.status == .failed {
                        
                        print("Sign In failed:: \(String(describing: rr.text))")
                    }
                    else {
                  
                        print("wwwwow...::\(rr.id ?? "")::x.signedIn.email:::\(rr.returnedObject?.email ?? "")::\(rr.returnedObject?.firstName ?? "") : accType: \(rr.returnedObject?.accountType ?? .others) :: dob::\(String(describing: rr.returnedObject?.dob))")
                      
                    }
                    
            }
        
        })

        
    }
    
    static func fetchUser(id : String){
        
        
        let a = ARH()
        
        a.fetchUser(id: id, completion: {
   
            res2 in
            
            switch(res2) {
            
                case .failure(let err) :
                    print("failed::.err:\(err)")
                    
                case .success(let user) :
                    print("Fetched!.in.user::\(user.firstName ?? "") \(user.lastName ?? "") dob ::\(String(describing: user.dob)) \(user.phoneNumber ?? "") \(user.email ?? "") stat::\(user.stat ?? .none))")
                    
            }
            
        })
   
    
    }
    
    
    static func testAddUser(){
        
        let u = User(id: "", firstName: "Jason", lastName: "Yong", dob: DateFormatter.date(from: "1975-10-20 00:00:00"), email: "xxman9090@gmail.com", phoneNumber: "+60128126882", stat: .signedOut )
        
        
        ARH.shared.addUser(u,
                           returnType: User.self,
                           completion: {
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    print("addedUser::id::\(String(describing: rr.id)) text:\(String(describing: rr.text)) :: \(rr.status)")
                   
            }
           
        })
        
    }
    
    
    
    static func fetchWallet(id : String, refId: String){
        
        ARH.shared.fetchUserWallet(id: id, refId: refId, completion: {
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    print("fetchedWallet!::id::\(rr.id ?? "")::\(rr.refId ?? "")::balance::\(rr.balance ?? 0)")
                   
            }
          
            
        })
    }
    
    
    static func testAddPayment(){
        
        var t = UserPaymentTx(uid:"Che_Rm92ndZL", amount: 25.00, currency: "MYR")
        
        ARH.shared.addUserPaymentTx(t, returnType: UserPaymentTx.self, completion: {
            
            res in
            
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    
                    if rr.status == .failed {
                        
                        print("paymentAdded:: Failed! \(rr.text ?? "")")
                
                    }
                    else {
                    
                        print("paymentAdded:: \(rr.id ?? "")")
                        
                        print("Trying to delete after 1 sec!!!")
                        
                        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1, execute: {
                            
                            //Tester.testDeletePayment(id: rr.id ?? "")
                            
                            t.amount = Double.random(in: 12...59)
                            t.id = rr.id
                            Tester.testUpdatePayment(t)
                        })
                
                    }
                    
            }
                    
            
            
        })
    }
    
    
    static func testUpdatePayment( _ payment : UserPaymentTx){
        
        ARH.shared.updateUserPaymentTx(payment ,returnType:  UserPaymentTx.self, completion: {
            
            res in
            
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    
                    if rr.status == .failed {
                        
                        print("payment update:: Failed! \(rr.text ?? "")")
                
                    }
                    else {
                    
                        print("payment updated:: \(rr.id ?? "")")
                
                    }
                    
            }
        })
    }
    
    
    static func testDeletePayment( id : String){
        
        ARH.shared.deleteUserPaymentTx(id: id,
                                       returnType: UserPaymentTx.self,
                                       completion: {
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    
                    if rr.status == .failed {
                        
                        print("payment Deletion:: Failed! \(rr.text ?? "")")
                
                    }
                    else {
                    
                        print("payment deleted:: \(rr.id ?? "")")
                
                    }
                    
            }
           
            
        })
    }
    
    
    static func testAddUserWallet(){
        
        var w = UserWallet(id: "Che_Rm92ndZL", balance: 5.00, currency: "MYR", type:.personal)
        
        ARH.shared.addUserWallet(w, returnType: UserWallet.self, completion: {
                
            res in
        
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    print("addedUserWallet!::id::\(rr.returnedObject?.id ?? "")::\(rr.returnedObject?.refId ?? "")")
                    
                    //Tester.fetchWallet(id: rr.returnedObject?.id ?? "", refId: rr.returnedObject?.refId ?? "")
                    w.id = rr.returnedObject?.id
                    w.refId = rr.returnedObject?.refId
                    
                    print("to.fetch.wallet..after 1 sec")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        
                       // w.balance = Double(Float.random(in: (20...60)))
                        //Tester.updateWallet(w)
                        //Tester.testDeleteWallet(w)
                        
                        Tester.fetchWallet(id: w.id ?? "", refId: w.refId ?? "")
                        
                    })
            
                   
            }
               
        })
    }
    
    static func updateWallet(_ wallet : UserWallet) {
        
        ARH.shared.updateUserWallet(wallet, returnType:  UserWallet.self, completion: {
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    
                    if rr.status == .failed {
                        
                        print("wallet update:: Failed! \(rr.text ?? "")")
                
                    }
                    else {
                    
                        print("wallet updated:: \(rr.returnedObject?.id ?? ""):: \(rr.returnedObject?.refId ?? "")")
                
                    }
                    
            }
            
        })
    }
    
    
    
    static func testDeleteWallet(_ wallet : UserWallet){
        
        ARH.shared.deleteUserWallet(wallet, returnType: UserWallet.self, completion: {
            
            res in
            
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    
                    if rr.status == .failed {
                        
                        print("wallet Deletion:: Failed! \(rr.text ?? "")")
                
                    }
                    else {
                    
                        print("wallet deleted:: \(rr.id ?? "")")
                
                    }
                    
            }
        })
    }
    
    
    static func testAddUserAddr(){
        
        let addr = UserAddress(id: "Che_Rm92ndZL",addrType:.work , line1: "Wisma Kenatex", line2: "Jln Tuaran",
                               postCode: "88844", city: "Kota Kinabalu", state: "Sabah", country: "MY")
        
        ARH.shared.addUserAddress(addr, returnType: UserAddress.self, completion: {
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    print("addedUserAddress!::id::\(String(describing: rr.id)) text:\(String(describing: rr.text)) :: \(rr.status)")
                   
            }
           
            
        })
    }
    
    
    static func testFetchUserAddress(){
        
        ARH.shared.fetchUserAddress(id: "Che_Rm92ndZL", completion: {
             
             res in
             
             switch (res) {
             
                 case .failure(let err) :
                     print("error!:\(err)")
                 case .success(let a) :
                    print("userAddressFetched!::\(a.line1 ?? "") \(a.line2 ?? "") :: \(a.postCode ?? "")")
                     
             }
             
         })
    }
    
    
    static func test(){
        
      
        
        var u2 = User()
        u2.id = "Key_5iNTy6tw"
        u2.phoneNumber = "+60128298188"
        u2.lastName = "Yun Ling"
        u2.firstName = "Teh"
        ARH.shared.updateUser(u2,returnType: User.self,completion: {
            
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let rr) :
                    print("updatedUser::id::\(String(describing: rr.id)) text:\(String(describing: rr.text)) :: \(rr.status)")
                   
            }
          
        })
        
        
        
        
        
        
        ARH.shared.fetchUser(phoneNumber: "+60138634848", completion: {
             
             res in
             
             switch (res) {
             
                 case .failure(let err) :
                     print("error!:\(err)")
                 case .success(let user) :
                     print("userByPhone::\(user.firstName ?? "") \(user.lastName ?? "") :: \(user.phoneNumber ?? "")")
                     
             }
             
         })
        
       ARH.shared.fetchUser(id: "Van_YE9EWOtl", completion: {
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let user) :
                    print("userById::\(user.firstName ?? "") \(user.lastName ?? "") :: \(user.id ?? "")")
                    
            }
            
        })
 
        ARH.shared.fetchUsers(completion: {
            
            res in
            
            switch (res) {
            
                case .failure(let err) :
                    print("error!:\(err)")
                case .success(let users) :
                    users.forEach{
                        user in
                        
                        print("user::\(user.id ?? "") : \(user.firstName ?? "") \(user.lastName ?? "")")
                    }
                    
            }
            
            
        })
        
    }
}
