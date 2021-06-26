//
//  PaymentFailureView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 26/06/2021.
//

import SwiftUI

struct PaymentFailureView : View {

    
    var body : some View {
        
        VStack{
            
            Text("Failure".localized).font(.custom(Theme.fontName, size: 30))
            
            Image(systemName: "die.face.1").resizable().frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit).foregroundColor(Color(UIColor(hex:"#ff2233ff")!))
           
            Text("Something Must Have Gone Wrong!!".localized).font(.custom(Theme.fontNameBold, size: 24))
            .foregroundColor(.red)
           
            
            Spacer()
              
        }
        .padding()
        .navigationBar(title : Text("Payment Failure".localized), displayMode: .inline)
        .backButton()
    }

}
