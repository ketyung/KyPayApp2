//
//  NeumorphismModifier.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import SwiftUI


extension Color {
    
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}


struct NeumorphismModifier : ViewModifier {
    
    
    func body(content : Content) -> some View{
        content
        .background(Color.offWhite)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
    }

}



extension View {
    
    func neumo() -> some View {
        
        self.modifier(NeumorphismModifier())
    }
}



