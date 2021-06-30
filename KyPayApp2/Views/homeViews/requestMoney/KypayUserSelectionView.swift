//
//  KypayUserSelectionView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 30/06/2021.
//

import SwiftUI


struct KypayUserSelectionView : View {
    
    @Binding var selectedContacts : [Contact]
    
    @Binding var kypayUsers : [KyPayUser]
    
    @State private var searchText : String = ""
    
    var body : some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Your contacts on KyPay").font(.custom(Theme.fontNameBold, size: 18))
            
            SearchBar(text: $searchText)
       
            List{
                
                if let users = kypayUsers {
                
                    ForEach(users.filter({ searchText.isEmpty ? true :
                    $0.firstName?.lowercased().contains(searchText.lowercased()) ?? false }), id : \.cnIdentifier){
                        
                        user in
                    
                        rowButton(user)
                    }
                }
                
            }
            
        }
       
    }
}

extension KypayUserSelectionView {

    
    private func rowButton (_ user : KyPayUser) -> some View {
        
        Button(action : {
            
            withAnimation {
            
                let contact = Contact(cnIdentifier: user.cnIdentifier ?? "",
                firstName: user.firstName ?? "", lastName:  user.lastName ?? "",
                phoneNumber:  user.phoneNumber ?? "")
                
                if !selectedContacts.contains(contact){
                    
                    selectedContacts.append(contact)
                }
                else {
                    selectedContacts.remove(object: contact)
                }
            }
            
        }){
            
            row(user)
            
        }
    }
    
    
    private func row(_ user : KyPayUser) -> some View {
        
        HStack(spacing:5) {
            
            ZStack{
                
                let f = user.firstName?.prefix(1).uppercased() ?? ""
                
                Circle().fill(Color.orange)
                .frame(width: 40, height: 40)
                
                let t = "\(f)\(user.lastName?.prefix(1).uppercased() ?? "")"
                Text(t)
                .font(.custom(Theme.fontNameBold, size: 18))
                .foregroundColor(.white)
            }
            
            Text("\(user.firstName ?? "") \(user.lastName ?? "")")
            .font(.custom(Theme.fontName, size: 16))
            .lineLimit(1)
           
            Spacer()
            
            Text(user.phoneNumber ?? "")
            .font(.custom(Theme.fontNameBold, size: 14))


        }
    }
}

