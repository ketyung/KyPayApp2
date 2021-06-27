//
//  RequestView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct RequestView : View {

    @State private var selectedContacts : [Contact] = [
    
        Contact(cnIdentifier: "0000", firstName: "K Y", lastName: "Chee", phoneNumber: "+60128122229"),
        Contact(cnIdentifier: "0001", firstName: "Jane", lastName: "Sung", phoneNumber: "+60128122129"),
        Contact(cnIdentifier: "0002", firstName: "Mary", lastName: "Chung", phoneNumber: "+60128122139"),
        Contact(cnIdentifier: "0004", firstName: "Wang", lastName: "Yang", phoneNumber: "+60138222129"),
        
    ]
    
    var body: some View{
        
        VStack{
            
            Text("Request From".localized).font(.custom(Theme.fontNameBold, size: 30))

            Text("You can select up to 5 numbers to split the bill among them!")
                .font(.custom(Theme.fontName, size: 16)).foregroundColor(.gray)
            
            self.contactsScrollView()
            
        }
    }
}


extension RequestView {
    
    private func contactsScrollView() -> some View {
        
        ScrollView (.horizontal, showsIndicators:false ){
            
            HStack (spacing: 20) {
             
                
                ForEach(self.selectedContacts, id:\.cnIdentifier) {
                    
                    contact in
                    
                    contactView(contact)
                }
            }.padding()
        }
    }
    
    
    private func contactView(_ contact : Contact) -> some View {
        
        ZStack{
            
            let f = contact.firstName.prefix(1).uppercased()
            
            Circle().fill(Color.orange)
            .frame(width: 50, height: 50)
            
            let t = "\(f)\(contact.lastName.prefix(1).uppercased())"
            Text(t)
            .font(.custom(Theme.fontNameBold, size: 18))
            .foregroundColor(.white)
            
            
            Button(action : {
                
                withAnimation{
                    
                    selectedContacts.remove(object: contact)
                }
            }){
           
                Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width:18, height: 18, alignment: .bottomTrailing)
                .foregroundColor(.black).offset(x: 20, y: 20)
               
            }
            
            
           
        }
       
    
    }
    
}
