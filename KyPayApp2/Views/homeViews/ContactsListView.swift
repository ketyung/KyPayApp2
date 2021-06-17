//
//  ContactsListView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import SwiftUI

struct ContactsListView : View {
    
    private let contacts = ContactFetcher.getContacts()
    
    @State private var searchText : String = ""
    
    var body : some View {
        
        
        VStack {
            
            SearchBar(text: $searchText)
       
            List{
                
                ForEach(contacts.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }), id : \.cnIdentifier){
                    
                    contact in
                
                    contactRow(contact)
                }
            }
            
        }
       
    }
}

extension ContactsListView {
    
    private func contactRow(_ contact : Contact) -> some View {
        
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
            
            Text(contact.phoneNumber)
            .font(.custom(Theme.fontNameBold, size: 14))


        }
    }
}
