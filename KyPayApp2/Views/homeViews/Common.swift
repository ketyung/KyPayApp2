//
//  Common.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 28/06/2021.
//

import SwiftUI

struct Common {
    
    
    static func paymentSuccessView (amount : String, balance : String,
    currency : String, subTitle : String = "Transfer Amount :".localized) -> some View {
        
        VStack{
            
            Text("Success".localized).font(.custom(Theme.fontName, size: 30))
            
            Image(systemName: "checkmark.circle").resizable().frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit).foregroundColor(Color(UIColor(hex:"#aaff22ff")!))
            
            VStack {
           
                Text(subTitle)
                .font(.custom(Theme.fontName, size: 20)).foregroundColor(Color(UIColor(hex:"#aaaabbff")!))
               
                Text("\(currency) \(amount)")
                .font(.custom(Theme.fontName, size: 20)).foregroundColor(Color(UIColor(hex:"#aaaabbff")!))
                   
            }
            
            
            Spacer().frame(height:30)
            
            VStack {
           
                Text("Current Balance :".localized)
                .font(.custom(Theme.fontNameBold, size: 26)).foregroundColor(Color(UIColor(hex:"#999999ff")!))
               
                Text("\(currency) \(balance)")
                .font(.custom(Theme.fontNameBold, size: 30)).foregroundColor(Color(UIColor(hex:"#333333ff")!))
                   
            }
            
            Spacer()
              
        }
    }
    
    
    static func errorAlertView( message : String) -> some View {
        
         VStack {
        
             Spacer().frame(height: 30)
             
             HStack (spacing: 2) {
             
                 Image(systemName: "info.circle.fill")
                 .resizable()
                 .frame(width:24, height: 24)
                 .foregroundColor(Color(UIColor(hex:"#aa0000ff")!))
                 
                 Text(message)
                 .padding()
                 .fixedSize(horizontal: false, vertical: true)
                 .font(.custom(Theme.fontName, size: 16))
                 .lineLimit(3)
             }
             .padding(4)
             
             Spacer()
         }
         .padding()
         .frame(width: UIScreen.main.bounds.width - 40, height: 200)
         .cornerRadius(4)
         

    }
}
