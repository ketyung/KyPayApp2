//
//  RequestChoiceView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 08/07/2021.
//

import SwiftUIX

struct RequestChoiceView : View {
    
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
   
    @EnvironmentObject private var moneyRequestViewModel : MoneyRequestViewModel
    
    @Binding var selectedContacts : [Contact]
    
    @State private var textFieldFocus : Bool = false
    
    var body: some View {
        
        VStack{
            
            amountTextField()
            
            dismissKeyboardButton()
            
            contactsView()
            
            
            Button(action : {
                
                
            }){
                Text("Proceed")
            }
            
            Spacer()
        }
    }
}


extension RequestChoiceView {
    
    private func amountTextField() -> some View {
    
        VStack(alignment: .leading, spacing: 8) {
       
            Text("How Much?".localized).font(.custom(Theme.fontNameBold, size: 26))
            .foregroundColor(.gray)
       
            HStack {
                Text("\(walletViewModel.currency)").font(.custom(Theme.fontNameBold, size: 18))
                .foregroundColor(.gray)
                
                CocoaTextField("Amount".localized, text: $moneyRequestViewModel.amountText)
                .keyboardType(.decimalPad)
                .foregroundColor(.black)
                .font(UIFont.boldSystemFont(ofSize: 46))
                .background(Color.white)
                .frame(width: 200, height: 24)
                .overlay(VStack{Divider().backgroundFill(.red).offset(x: 0, y: 26)})
                .onTapGesture {
                    
                    textFieldFocus = true
                }
                    
            }
           
        }
        
    }
  
    
    private func contactsView() -> some View {
        
        VStack(alignment: .leading ) {
         
            Text("From :").font(.custom(Theme.fontNameBold, size: 24))
            .foregroundColor(.gray)
           
            
            List(selectedContacts, id:\.cnIdentifier){
                
                contact in
                
                
                contactRow(contact)
            }
        }
    }
    
    
    private func contactRow( _ contact : Contact ) -> some View {
        
        HStack(spacing:5) {
            
            ZStack{
                
                let f = contact.firstName.prefix(1).uppercased()
                
                Circle().fill(Color.orange)
                .frame(width: 40, height: 40)
                
                let t = "\(f)\(contact.lastName.prefix(1).uppercased())"
                Text(t)
                .font(.custom(Theme.fontNameBold, size: 18))
                .foregroundColor(.white)
            }
            
            Text(contact.name)
            .font(.custom(Theme.fontName, size: 16))
            .lineLimit(1)
           
            Spacer()
            
            TextField("Amount", text: $moneyRequestViewModel.amountOfFocus)
            .keyboardType(.decimalPad)
            .frame(width: 100).onTapGesture {
                
                self.moneyRequestViewModel.focusIndexByPhoneNumber(contact.phoneNumber)
                withAnimation{
                    
                    self.textFieldFocus = true
                }
            }
            
        }
    }
}


extension RequestChoiceView {
    
    private func dismissKeyboardButton() -> some View {
        
        HStack(spacing:20) {
       
            Spacer()
            .frame(width:5)
            
            Button(action: {
                withAnimation {
                    
                    self.endEditing()
                }
            }){
                
                Image(systemName: "arrowtriangle.down.circle.fill")
                .resizable()
                .frame(width:20, height: 20, alignment: .topLeading)
                .foregroundColor(.gray)
                
            }
            
            Spacer()
        }
        .hidden(!textFieldFocus)
    }
    
    
    private func endEditing(){
      
        UIApplication.shared.endEditing()
        withAnimation{
  
            self.textFieldFocus = false
      
        }
    }
}
