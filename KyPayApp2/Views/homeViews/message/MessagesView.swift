//
//  MessagesView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 03/07/2021.
//

import SwiftUI

struct MessagesView : View {
    
    @ObservedObject private var messagesViewModel = MessagesViewModel()
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    
    var body: some View {
        
        VStack {
            
            List(messagesViewModel.messages, id:\.id){
                
                mesg in
            }
            
        }
        .popOver(isPresented:$messagesViewModel.errorPresented , content: {
            
            Common.errorAlertView(message: messagesViewModel.errorMessage)
            
        })
        .onAppear{
        
            messagesViewModel.fetchMessages(userId: userViewModel.id)
        }
    }
}


extension MessagesView {
    
    
}
