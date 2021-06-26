//
//  PaymentRedirectView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 26/06/2021.
//

import SwiftUI

struct PaymentRedirectView : View {
    
    let url : URL?
    
    var body: some View {
        
        VStack{
    
            PaymentRedirectWebView(url: url)
            .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        }
        .backButton()
    }
}
