//
//  SendMoneyView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 19/06/2021.
//

import SwiftUIX

struct SendMoneyView : View {
    
    let txInputViewModel : TxInputDataViewModel
    
    @State private var amountText : String = ""
    
    var body : some View {
        
        VStack(alignment: .leading, spacing:20) {
            
            Text("How Much?".localized)
            .font(.custom(Theme.fontNameBold, size: 40))
            .onTapGesture {self.endEditing()}
            
            Spacer()
            .frame(height:30)
            
            amountTextField()
            
            recipientView()
            
            Spacer()
        }
        .padding(.leading, 20)
        .backButton(additionalAction: {
            self.endEditing()
        })
        .bottomFloatingButton( isPresented: true, action: {
    
        })
    }
    
}


extension SendMoneyView {
    
    private func amountTextField() -> some View {
    
        CocoaTextField("Amount".localized, text: $amountText)
        .keyboardType(.numberPad)
        .foregroundColor(.black)
        .font(UIFont.boldSystemFont(ofSize: 36))
        .background(Color.white)
        .frame(width: 200, height: 24)
        .overlay(VStack{Divider().backgroundFill(.red).offset(x: 0, y: 26)})
        
    }
    
    
    private func recipientView() -> some View{
        
        HStack {
            
            Text(txInputViewModel.selectedUserPhoneNumber)
            .font(.custom(Theme.fontName, size: 18))
            
            Text(txInputViewModel.selectedUserName)
            .font(.custom(Theme.fontName, size: 18))
            
        }.padding()
        
    }
    
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}
