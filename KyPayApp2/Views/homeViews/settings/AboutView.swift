//
//  AboutView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 07/07/2021.
//

import SwiftUI

struct AboutView : View {
    
    @Binding var isPresented : Bool
    
    @Binding var toPresentBlog : Bool
    
    var body : some View {
        
        ScrollView(.vertical, showsIndicators : false ){
        
            
            VStack (alignment: .leading, spacing:30){
                
                Text("The KyApp starts as an eWallet and shopping market place app, built for the Rapyd Hackathon. It's hoped that the app could evolve into a universal app which consists of the KyPay - for receiving and sending money, the KyShop for KyPay users to start selling and buyers to buy and KySeller for sellers to manage their items and orders").font(.custom(Theme.fontName, size: 16)).foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true).lineLimit(10).frame(minWidth:300)
              
                Text("UI, iOS app & Backend designed & developed by:").font(.custom(Theme.fontName, size: 18)).foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true).lineLimit(3)
                
                
                Text("Chee Ket Yung (also known as Christopher K Y Chee)").font(.custom(Theme.fontNameBold, size: 18)).foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true).lineLimit(3)
                
                Text("Contact : ketyung@techchee.com").font(.custom(Theme.fontNameBold, size: 16))
                    .foregroundColor(Color(UIColor(hex:"#006699ff")!))
                
                Button(action: {
                    
                    
                    withAnimation{
                        
                        isPresented = false
                        toPresentBlog = true 
                    }
                }){
                
                    Text("Blog: https://blog.techchee.com").font(.custom(Theme.fontNameBold, size: 16))
                        .foregroundColor(Color(UIColor(hex:"#3366ffff")!))
                 
                }
                
                
                Text("Version \(Bundle.main.releaseVersionNumberPretty)").font(.custom(Theme.fontName, size: 18)).foregroundColor(Color(UIColor(hex:"#666666ff")!))
                
                
                  
            }
            .padding()
            
        }
        .frame(minHeight: UIScreen.main.bounds.height - 400)
   
    }
}
