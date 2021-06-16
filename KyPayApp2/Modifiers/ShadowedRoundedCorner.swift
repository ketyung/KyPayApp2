//
//  ShadowedRoundedCorner.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 16/06/2021.
//

import SwiftUI



struct ShadowedRoundedCorner : ViewModifier{
    
    let cornerRadius : CGFloat
    
    let shadowRadius : CGFloat 

    func body(content : Content) -> some View{
        content
        .padding(6)
        .background(Color.white)
        .cornerRadius(cornerRadius)
        .shadow(radius: shadowRadius )
    }
}


extension View {
    
    func rounded(cornerRadius : CGFloat = 10, shadowRadius : CGFloat = 10) -> some View {
        self.modifier(ShadowedRoundedCorner(cornerRadius : cornerRadius, shadowRadius : shadowRadius))
    }
}
