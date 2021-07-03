//
//  ApiRequestHandler.swift
//  KyPay
//
//  Created by Chee Ket Yung on 07/06/2021.
//

import Foundation

typealias ARH = ApiRequestHandler


struct ApiError : LocalizedError, CustomStringConvertible {
    
    var errorText : String?
    
    var statusCode : Int?
    
    public var description: String {
        
        "\(errorText ?? "Unknown error".localized)"
    }

    public var errorDescription : String {
        
        errorText ?? "Unknown error".localized
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
    
    static func defaultAsOk (type : R.Type) -> ReturnedResult {
        
        return ReturnedResult(status: .ok)
    }
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
    
    //    "https://techchee.com/KyPayApiTestPointV1/" //
    
    private var token : String? = nil
    
    private let useOta : Bool = false 
    
    override init(){
        
        super.init()
        if !useOta {
            token = "Basic://7625bavaVDf2fnak3lKL908337aland#a2op_j3nankLK_63535vvVAf53535AFAF63663_9283737AHGHgsa_92777jah3TAY3a"
        }
    }
}

extension ApiRequestHandler {
   
    func fetch <T:Decodable> (module : String, param : String? = nil, decode to : T.Type? = nil,
        completion:  ((Result<T, Error>)->Void)? = nil ){
        
        
        guard let _ = self.token else {
       
            obtainToken(completion: {
                token, err in
                
                if err != nil {
                    print("Error.obtaining.token::\(String(describing: err))")
                    return
                }
            
                
                self.token = token
                
               // print("token::\(String(describing: token))")
                self.fetchWOA(module: module, param: param , decode: to , completion: completion)
            })
           
            return
            
        }
        

        fetchWOA(module: module, param: param , decode: to , completion: completion)
    }
    
    func fetchWOA <T:Decodable> (module : String, param : String? = nil, decode to : T.Type? = nil,
        completion:  ((Result<T, Error>)->Void)? = nil ){
        
        var urlString = "\(urlBase)\(module)"
        
        if let param = param {
            
            urlString.append("/\(param)")
        }
        
        if let url = URL(string: urlString) {
       
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = [
              "Content-Type": "application/json",
              "Authorization" : token ?? "" ]

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
                            
                            completion(.failure(ApiError(errorText: "Response status code :\(httpResponse.statusCode)", statusCode: httpResponse.statusCode)))
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
        
        guard let _ = self.token else {
       
            obtainToken(completion: {
                token, err in
                
                if err != nil {
                    print("Error.obtaining.token::\(String(describing: err))")
                    return
                }
                
                self.token = token
                
                //print("self.token::\(String(describing: self.token))")
                
                self.sendWOA(module: module, param: param, dataObject: dataObject, returnType: returnType, completion: completion, method: method)
                
            })
           
            return
            
        }
        
        sendWOA(module: module, param: param, dataObject: dataObject, returnType: returnType, completion: completion, method: method)
    }
    
    
    func sendWOA <T:Codable, R:Decodable> (module : String, param : String? = nil,
    dataObject : T? = nil, returnType : R.Type? = nil,
    completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil,
    method : String = "POST"){
        
        
        var urlString = "\(urlBase)\(module)"
        
        if let param = param {
            
            urlString.append("/\(param)")
        }
        
        
        if let url = URL(string: urlString) {
       
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Content-Type": "application/json","Authorization" : token ?? "" ]
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method
       
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = DateFormatter.encodingStrategy
            
            if let object = dataObject  {
           
                if let encoded = try? encoder.encode(object) {
                    
                    request.httpBody = encoded
                }
            }
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
              
                guard error == nil else {
                    print("error::\(String(describing: error))")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse{
                    
                    guard (200 ... 299) ~= httpResponse.statusCode else{
               
                        if let completion = completion {
                       
                            completion(.failure(ApiError(errorText: "Response status code :\(httpResponse.statusCode)", statusCode: httpResponse.statusCode)))
                        }
                        
                        return 
                    }
                    
                    
                    if let returnType = returnType {
                        
                        self.decodeJson(ReturnedResult.self, data: data, returnType: returnType, completion: completion)
                    
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
    data : Data?, returnType : R.Type ,completion:  ((Result<T, Error>)->Void)? = nil ,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = DateFormatter.decodingStrategy,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase){
        
        do {
         
            if let data = data {
          
                let decoder = JSONDecoder()
                
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy
             
                decoder.userInfo = [.returnTypeKey : returnType]
                
               // data.count will be 0, if the http response code is 204
                if data.count > 0 {
               
                    if let completion = completion {
              
                        let results = try decoder.decode(type, from: data)
                      
                         completion(.success(results))
                    }
                   
                }
               
                else {
                    
                    if let completion = completion {
                    
                        let res = ReturnedResult.defaultAsOk(type: returnType)
                        completion(.success(res as! T))
                        
                    }
            
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

extension ApiRequestHandler {
    
    
    private struct Token : Decodable{
        
        var accessToken : String?
        
        var tokenType : String?
        
    }
    
    
    private func obtainToken (completion : ((String?, Error?)->Void)? = nil){
        
        let issuer = "https://dev-82517996.okta.com/oauth2/default"
        let clientId = "0oazeqvrdJVvHRJA25d6"
        let secret = "snUceW-lq5eVA2MWpvXNtR4yoLHSY92QQQL4Z3eF"
        let scope = "kypay_api"
        
        let urlString = "\(issuer)/v1/token"
        
        
        if let url = URL(string: urlString) {
       
            let token = "\(clientId):\(secret)".data(using: .utf8)

            if let b64Token = token?.base64EncodedString() {
                
                //print("b64Token::\(b64Token)")
                
                var request = URLRequest(url: url)
                request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded","Authorization" :"Basic \(b64Token)" ]
                
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                
                
                let payload : [String : String] = ["grant_type": "client_credentials", "scope": scope]
                
                request.httpBody =  payload.percentEncoded()
        
            
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                  
                    guard error == nil else {
                        print("error::\(String(describing: error))")
                        return
                    }
                    
                    
                    
                    if let httpResponse = response as? HTTPURLResponse{
                        
                        
                        guard (200 ... 299) ~= httpResponse.statusCode else{
                            
                            
                            if let completion = completion {
                                
                                completion(nil, ApiError(errorText: "Obtaining token error :: response code :\(httpResponse.statusCode)", statusCode: httpResponse.statusCode))
                            }
                            
                            return
                        }
                        
                        
                        self.decodeJson(Token.self, data: data, completion: {
                            
                            res in
                            
                            switch(res){
                            
                                case .failure(let err) :
                                    
                                    if let completion = completion {
                                        
                                        completion(nil, err)
                                    }
                                    
                                case .success(let rr) :
                                    
                                    if let completion = completion {
                                        
                                        completion("\(rr.accessToken ?? "")", nil )// \(rr.tokenType ?? "")", nil)
                                    }
                                    
                                    
                                
                            }
                            
                        })
                        
                    }
                    
                }.resume()
                
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
    
    
    func signInUser <R:Decodable> (phoneNumber : String, returnType : R.Type? = nil,
                                   completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil) {
    
        let user = User(phoneNumber : phoneNumber)
        send(module: "user", param: "signIn", dataObject: user, returnType: returnType,
             completion:  completion, method: "PUT")
    }
    
    
    func signOutUser <R:Decodable> (_ user : User, returnType : R.Type? = nil,
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
    

    func updateUserWallet <R:Decodable> (_ wallet : UserWallet, returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "userWallet", param: "update", dataObject: wallet,
             returnType: returnType,completion:  completion, method: "PUT")
    }
    
    func deleteUserWallet <R:Decodable> (_ wallet : UserWallet,
        returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "userWallet", dataObject: wallet, returnType: returnType,
             completion:  completion,method: "DELETE")
    }
  
    
    
    func fetchUserWallet (id : String, refId : String,
                           completion:  ((Result<UserWallet, Error>)->Void)? = nil ){
        
        fetch(module: "userWallet", param: "id/\(id)/\(refId)" , decode: UserWallet.self, completion: completion)
    }
    
    
    func fetchUserWallet (id : String, type : UserWallet.WalletType , currency : String,
                           completion:  ((Result<UserWallet, Error>)->Void)? = nil ){
        
        let param = "id/\(id)/\(type.rawValue)/\(currency)"
        
        //print("fetching.wallet.param::\(param)")
        fetch(module: "userWallet", param: param ,
              decode: UserWallet.self, completion: completion)
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
             dataObject: tx, returnType: returnType, completion:  completion,method: "DELETE")
    }
   
    
    
    func fetchUserPaymentTx (id : String,
                           completion:  ((Result<UserPaymentTx, Error>)->Void)? = nil ){
        
        fetch(module: "userWallet", param: "id/\(id)" , decode: UserPaymentTx.self, completion: completion)
    }
    
    
    
}

extension ApiRequestHandler {
    
    func saveDeviceToken <R:Decodable> (_ token : DeviceToken, returnType : R.Type? = nil, completion:  ((Result<ReturnedResult<R>, Error>)->Void)? = nil){
        
        send(module: "deviceToken", dataObject: token, returnType: returnType,completion:  completion)
    }
}


extension ApiRequestHandler {
    
    func fetchBillers (country : String, completion:  ((Result<[Biller], Error>)->Void)? = nil ){
        
        fetch(module: "biller", param: "country/\(country)" , decode: [Biller].self, completion: completion)
    }
  
}

extension ApiRequestHandler {
    
    func fetchMessages (userId : String, completion:  ((Result<[Message], Error>)->Void)? = nil ){
        
        fetch(module: "message", param: "user/\(userId)" , decode: [Message].self, completion: completion)
    }
  
}
