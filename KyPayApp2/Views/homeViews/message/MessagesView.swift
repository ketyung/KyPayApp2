//
//  MessagesView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 03/07/2021.
//

import SwiftUI

struct MessagesView : View {
    
    @EnvironmentObject private var messagesViewModel : MessagesViewModel
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Spacer()
            .frame(height:30)
           
            Text("Messages").font(.custom(Theme.fontNameBold, size: 30))
            
            List(messagesViewModel.messages, id:\.id){
                
                mesg in
                
                messageRowView(mesg)
            }
            
        }
        .padding()
        .popOver(isPresented:$messagesViewModel.errorPresented , content: {
            
            Common.errorAlertView(message: messagesViewModel.errorMessage)
            
        })
        
    }
}


extension MessagesView {
    
    private func messageRowView(_ message : Message) -> some View {
        
        HStack {
            
            Image(iconImageNameOf(messageType: message.type)).resizable()
            .frame(width:24, height:24).aspectRatio(contentMode: .fit)
            
            Spacer().frame(width: 15)
            
            VStack(alignment: .leading) {
                
                Text(message.title ?? "").font(.custom(Theme.fontNameBold, size: 18))
                    .foregroundColor(Color(UIColor(hex:"#999999ff")!))
                
                Text(message.subTitle ?? "").font(.custom(Theme.fontName, size: 16))
                
            }
            
            Spacer()
            
            Common.disclosureIndicator()
            
            Spacer().frame(width: 3)
           
        }.frame(maxHeight: 60)
    }
    
    
    private func iconImageNameOf(messageType : Message.MessageType? ) -> String {
        
        if let messageType = messageType {
         
            switch(messageType){
                
                case .moneyReceived :
                    return "moneyReceived"
                    
                case .moneyRequestedByOthers :
                
                    return "withdraw"
            }
        }
        
        return ""
    }
    
}
