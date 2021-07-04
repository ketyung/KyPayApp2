//
//  Common.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 28/06/2021.
//

import SwiftUIX

struct Common {
    
    
    static func paymentSuccessView (amount : String, balance : String,
    currency : String, showBalance : Bool = true, withLogo : Bool = false,
    note : String? = nil, subTitle : String = "Transfer Amount :".localized) -> some View {
        
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
            
            if let note = note, !note.isEmpty {
                
                VStack(spacing:2) {
                    
                    Spacer().frame(height:5)
                    
                    Text("Note :").font(.custom(Theme.fontName, size: 16))
                    
                    Text("\(note)").font(.custom(Theme.fontName, size: 16))
                    .foregroundColor(Color(UIColor(hex:"#666666ff")!))
                    
                }
                
            }
            
            if showBalance {
               
                Spacer().frame(height:30)
               
                
                VStack {
               
                    Text("Current Balance :".localized)
                    .font(.custom(Theme.fontNameBold, size: 26)).foregroundColor(Color(UIColor(hex:"#999999ff")!))
                   
                    Text("\(currency) \(balance)")
                    .font(.custom(Theme.fontNameBold, size: 30)).foregroundColor(Color(UIColor(hex:"#333333ff")!))
                       
                }
                Spacer()
               
            }
            else {
                
                Spacer().frame(height:50)
               
            }
            
            
            if withLogo {
                
                HStack(spacing:2) {
                    
                    Spacer()
                
                    Image("logo").resizable().frame(width:36, height: 36).aspectRatio(contentMode: .fit)
                
                    Spacer().frame(width:3)
                
                }
            }
            
              
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

extension Common {
    
    static func disclosureIndicator() -> some View {
        
        Image(systemName: "chevron.right")
        .font(.body).foregroundColor(Color(UIColor(hex:"#aaaaaaff")!))
    }
    
    
    static func imagePlaceHolderView() -> some View {
        ZStack {
   
            Circle().fill(Color(UIColor(hex:"#bbbbccff")!)).frame(width: 32, height: 32)
            
            ActivityIndicator().frame(width:24, height: 24).tintColor(.white)
        }
    }
    
    
    
   
}

extension Common {
    
    static let defaultCurrency : String = "MYR"
    
    static let defaultCountry : String = "MY"
}
