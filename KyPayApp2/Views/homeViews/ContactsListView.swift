//
//  ContactsListView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import SwiftUI
import ContactsUI

struct ContactsListView : View {
    
    private let contacts = ContactFetcher.getContacts()
    
    var body : some View {
        
        List{
            
            ForEach(contacts, id : \.identifier){
                
                contact in
            
                contactRow(contact)
            }
        }
    }
}

extension ContactsListView {
    
    private func contactRow(_ contact : CNContact) -> some View {
        
        HStack(spacing:5) {
            
            ZStack{
                
                Circle().fill(Color.orange)
                .frame(width: 40, height: 40)
                
                let t = "\(contact.givenName.prefix(1).uppercased())\(contact.familyName.prefix(1).uppercased())"
                Text(t)
                .font(.custom(Theme.fontName, size: 20))
                .foregroundColor(.white)
            }
            
            Text(contact.givenName)
            .font(.custom(Theme.fontName, size: 16))
            .lineLimit(1)
           
            Text(contact.familyName)
            .font(.custom(Theme.fontName, size: 16))
            .lineLimit(1)
               
            Text(contact.phoneNumbers.first?.value.stringValue ?? "")
            .font(.custom(Theme.fontName, size: 16))

        }
    }
}
