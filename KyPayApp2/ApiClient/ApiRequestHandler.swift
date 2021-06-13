//
//  ApiRequestHandler.swift
//  KyPay
//
//  Created by Chee Ket Yung on 07/06/2021.
//

import Foundation

typealias ARH = ApiRequestHandler


struct ApiError : Error {
    
    var errorText : String?
    
    public var description: String {
        
        if let error = errorText {
            
            return error
        }
        
        return ""
    }
}


extension CodingUserInfoKey {
    static let returnTypeKey = CodingUserInfoKey(rawValue: "ReturnTypeKey")!
}


struct ReturnedResult <R:Decodable> : Decodable {
    
    enum Status : Int, Decodable {
        
        case ok = 1
        
        case failed = -1
        
        case none = 0
    }
    
    var id : String?
    
    var text : String?
    
    var date : Date?
    
    var status : Status = .ok
    
    var returnedObject : R?
    
}

extension ReturnedResult {
    
    enum CodingKeys: String, CodingKey {
       case id
       case text
       case status
       case date
       case returnedObject
   }
    
   init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        date = try values.decodeIfPresent(Date.self, forKey: .date)
        status = try values.decodeIfPresent(Status.self, forKey: .status) ?? .none
        
        if let returnType = decoder.userInfo[.returnTypeKey] as? R.Type {
     
            returnedObject = try values.decodeIfPresent(returnType, forKey:.returnedObject)
        }
    }
}


public enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

class ApiRequestHandler : NSObject {
        
    static let shared = ApiRequestHandler()

    private let urlBase = "http://127.0.0.1:808/"
    
    private let token = "eyJraWQiOiJuNnFOTTgxaERYd3hGVWczMnVtZ2l0MzdHQW1DWTBmc3BvempsYmdFMEo0IiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULkpfRElPdHliNXBGdGY3dDFCbGRwUnBrVkVtS1dZaGJGZy05T05keFVaeW8iLCJpc3MiOiJodHRwczovL2Rldi04MjUxNzk5Ni5va3RhLmNvbS9vYXV0aDIvZGVmYXVsdCIsImF1ZCI6ImFwaTovL2RlZmF1bHQiLCJpYXQiOjE2MjM0ODMyNTYsImV4cCI6MTYyMzQ4Njg1NiwiY2lkIjoiMG9hemVxdnJkSlZ2SFJKQTI1ZDYiLCJzY3AiOlsia3lwYXlfYXBpIl0sInN1YiI6IjBvYXplcXZyZEpWdkhSSkEyNWQ2In0.BB0CEIGc7fw5QZQ4qZLN527JuzN73ueB06Oh3ws7_VL6heb6aHhCRDAH9W5t4-mUS7nbKKaA9a7Sl-odnSyVYS2Mm7eWkqD-QAYv6dSej7LH4F_jSe7auwWZnqkJjzK8g--9Sv3uNvcgtiORQ9c4P-O9xHQBRMzzHdlHjqEqauSIvejTQQT7c8zHDN_lmNGeTLKMHbNfASLZKFF9UhEQ5a-vmtMAy-5ZbgdJsOX0SAW54pw2KCQHvFJRDyx8DMCP-bpNfE40i4LtIz2lWbMOXFmOebFmTnHJhfuPj--yk9VYeApogE6huA1SzZZaKkpeejRlxWW0PMeSkkLBePnFgg"
    
    func fetch <T:Decodable> (module : String,
        param : String? = nil, decode to : T.Type? = nil,
        completion:  ((Result<T, Error>)->Void)? = nil ){
        
        var urlString = "\(urlBase)\(module)"
        
        if let param = param {
            
            urlString.append("/\(param)")
        }
        
        if let url = URL(string: urlString) {
       
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
              "Content-Type": "application/json",
              "Authorization" : token ]

            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
              
              guard error == nil
              else {
                print("error::\(String(describing: error))")
                return
              }
              
              guard let data = data, let response = response
              else { return }
               
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        
                        if let decodeTo = to {
                            
                            self.decodeJson(decodeTo, data: data, completion:  completion)
                        }
                    }
                    else {
                        
                        if let completion = completion {
                            
                            completion(.failure(ApiError(errorText: "Response status code :\(httpResponse.statusCode)")))
                        }
                    }
                    
                    
                }
                
                
            }.resume()
        }
        
       
    }
    
    
}


extension ApiRequestHandler {
    
    func send <T:Codable, R:Decodable> (module : String, param : String? = nil,
    dataObject : T? = nil, returnType : R.Type? = nil,
    completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil,
    method : String = "POST"){
        
        
        var urlString = "\(urlBase)\(module)"
        
        if let param = param {
            
            urlString.append("/\(param)")
        }
        
        
        if let url = URL(string: urlString) {
       
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Content-Type": "application/json",
            "Authorization" : token ]
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method
       
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = DateFormatter.encodingStrategy
            
            if let object = dataObject  {
           
                if let encoded = try? encoder.encode(object) {
                    
                    
                    request.httpBody = encoded
                    // send as JSON directly
                    // There isn't a need to convert to parameters
                    /**
                    if let params = try? JSONSerialization.jsonObject(with: encoded)
                        as? [String: Any] ?? [:] {
                    
                        request.httpBody = params.percentEncoded()
                        
                    }*/
                }
            }
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
              
                guard error == nil else {
                    print("error::\(String(describing: error))")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    guard (200 ... 299) ~= httpResponse.statusCode else{
                        
                        return 
                    }
                    
                    
                    if let returnType = returnType {
                
                        self.decodeJson(ReturnedResult.self, data: data,
                                        returnType: returnType,
                                        completion: completion)
                    
                    }
                    else {
                        
                        self.decodeJson(ReturnedResult.self, data: data, completion: completion)
                    
                    }
                      
                }
              
                
            }.resume()
            
        }
        
    }
}



extension ApiRequestHandler {
    
    
    
    private func decodeJson <T:Decodable> (_ type : T.Type , data : Data?,
    completion:  ((Result<T, Error>)->Void)? = nil ,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = DateFormatter.decodingStrategy,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase){
        
        do {
         
            if let data = data {
          
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy
             
              
                let results = try decoder.decode(type, from: data)
               
                if let completion = completion {
                
                     completion(.success(results))
                }
               
            }
            
        }
        catch {
            
            if let completion = completion {
                completion(.failure(error))
            }
        }
    }
    
    
  
    
    
    private func decodeJson <T:Decodable, R:Decodable> (_ type : T.Type ,
    data : Data?, returnType : R.Type,
    completion:  ((Result<T, Error>)->Void)? = nil ,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = DateFormatter.decodingStrategy,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase){
        
        do {
         
            if let data = data {
          
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy
             
                decoder.userInfo = [.returnTypeKey : returnType]
                
                let results = try decoder.decode(type, from: data)
               
                if let completion = completion {
                
                     completion(.success(results))
                }
               
            }
            
        }
        catch {
            
            if let completion = completion {
                completion(.failure(error))
            }
        }
    }
    
  
}

// user
extension ApiRequestHandler {
    
    
    func fetchUser (id : String, completion:  ((Result<User, Error>)->Void)? = nil ){
        
        fetch(module: "user", param: "id/\(id)" , decode: User.self, completion: completion)
    }
    
    
    
    func fetchUser (phoneNumber : String, completion:  ((Result<User, Error>)->Void)? = nil ){
        
        fetch(module: "user", param: "phoneNumber/\(phoneNumber)" , decode: User.self, completion: completion)
    }
    
    
    
    func fetchUsers ( completion:  ((Result<[User], Error>)->Void)? = nil ){
        
        fetch(module: "user", decode: [User].self, completion: completion)
    }
    
    
    func addUser <R:Decodable> (_ user : User,returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "user", dataObject: user, returnType: returnType,completion:  completion)
    }
    
    
    func updateUser  <R:Decodable> (_ user : User, returnType : R.Type? = nil,completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "user", param: "update", dataObject: user, returnType: returnType,
             completion:  completion, method: "PUT")
    }
    
    
    func signInUser <R:Decodable> (phoneNumber : String,
                                   returnType : R.Type? = nil,
                                   completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil) {
    
        let user = User(phoneNumber : phoneNumber)
        send(module: "user", param: "signIn", dataObject: user, returnType: returnType,
             completion:  completion, method: "PUT")
    }
    
    
    func signOutUser <R:Decodable> (_ user : User,
                                    returnType : R.Type? = nil,
                                    completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil) {
    
        send(module: "user", param: "signOut", dataObject: user, returnType: returnType,
             completion:  completion, method: "PUT")
    }
    
}


// address
extension ApiRequestHandler {
    
    
    func addUserAddress <R:Decodable> (_ address : UserAddress, returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "userAddress", dataObject: address, returnType: returnType,completion:  completion)
    }
    
    
    
    func fetchUserAddress (id : String, type : UserAddress.AddrType = .residential,
                           completion:  ((Result<UserAddress, Error>)->Void)? = nil ){
        
        fetch(module: "userAddress", param: "id/\(id)/\(type.rawValue)" , decode: UserAddress.self, completion: completion)
    }
    
}

// wallet
extension ApiRequestHandler {
    
    
    func addUserWallet <R:Decodable> (_ wallet : UserWallet, returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "userWallet", dataObject: wallet, returnType: returnType,completion:  completion)
    }
    
    
    
    func fetchUserWallet (id : String, refId : String,
                           completion:  ((Result<UserWallet, Error>)->Void)? = nil ){
        
        fetch(module: "userWallet", param: "id/\(id)/\(refId)" , decode: UserWallet.self, completion: completion)
    }
    
}


// wallet
extension ApiRequestHandler {
    
    func addUserPaymentTx <R:Decodable> (_ tx : UserPaymentTx, returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "userPayment", dataObject: tx, returnType: returnType,completion:  completion)
    }
    
    
    func updateUserPaymentTx <R:Decodable> (_ tx : UserPaymentTx, returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "userPayment", param: "update", dataObject: tx,
             returnType: returnType, completion:  completion,method: "PUT")
    }
    
   
    func deleteUserPaymentTx <R:Decodable> (id : String, returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        let tx = UserPaymentTx(id: id)
        
        send(module: "userPayment",
             dataObject: tx,
             returnType: returnType, completion:  completion,method: "DELETE")
    }
   
    
    
    func fetchUserPaymentTx (id : String,
                           completion:  ((Result<UserPaymentTx, Error>)->Void)? = nil ){
        
        fetch(module: "userWallet", param: "id/\(id)" , decode: UserPaymentTx.self, completion: completion)
    }
    
    
    
}
