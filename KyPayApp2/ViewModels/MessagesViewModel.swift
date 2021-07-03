//
//  MessagesViewModel.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 03/07/2021.
//

import Foundation

class MessagesViewModel : ObservableObject {
    
    @Published var messages : [Message] = []
    
    @Published var errorMessage : String = ""
    
    @Published var errorPresented : Bool = false
    
    
    func fetchMessages(userId : String, completion : ((Error?)->Void)? = nil ){
        
        ARH.shared.fetchMessages(userId: userId, completion: {
            
            res in
            
            switch(res) {
            
                case .failure(let err) :
                    
                    DispatchQueue.main.async {
                    
                        self.errorMessage = err.localizedDescription
                        self.errorPresented = true
                    }
                    completion?(err)
            
                case .success(let messages) :
                    
                    DispatchQueue.main.async {
                        self.messages = messages
                        self.errorPresented = false 
                    }
                    
                    completion?(nil)
            }
        })
    }
}
