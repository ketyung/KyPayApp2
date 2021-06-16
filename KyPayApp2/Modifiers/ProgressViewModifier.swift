//
//  ProgressViewModifier.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct ProgressViewModifier : ViewModifier {
    
    @Binding var isShowing : Bool
    
    var text : String
    var size : CGSize
    var color : Color
    
    func body(content: Content) -> some View {
    
        ZStack {
            
            content
            
            if isShowing {
                
                withAnimation {
                    
                    showProgressView()
                }
            }
        }
    }
    
}


extension ProgressViewModifier {
    
    private func showProgressView() -> some View {
        
        VStack (spacing : 20) {
            
            CustomActivityIndicator(color: self.color, isRunning:  self.$isShowing)
            
        
            Text(text)
            .foregroundColor(.black)
            .font(.headline)
        }
        .frame(width: size.width, height: size.height)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20 )
    }
    
    
}


extension View {
    
    func progressView(isShowing: Binding <Bool>, text : String = "Loading...", size : CGSize =  CGSize(width:100, height:100), color : Color = .purple) -> some View{
        
        self.modifier(ProgressViewModifier(isShowing: isShowing, text: text, size: size, color: color))
    }
}
