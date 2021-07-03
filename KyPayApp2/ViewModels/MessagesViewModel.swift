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
    
    
    func fetchMessages(userId : String ){
        
        
        ARH.shared.fetchMessages(userId: userId, completion: {[weak self] res in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
           
                switch(res) {
                
                    case .failure(let err) :
                        
                        
                        self.errorMessage = err.localizedDescription
                        self.errorPresented = true
                      
                    case .success(let messages) :
                        
                        self.messages = messages
                        self.errorPresented = false
                        
                        
                }
            }
        })
    }
}
