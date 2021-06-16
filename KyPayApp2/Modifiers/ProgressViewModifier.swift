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
    var showsGrayOverlay : Bool = true
    
    
    func body(content: Content) -> some View {
    
        ZStack {
            
            content
            
            if isShowing {
                
                if showsGrayOverlay {
                    progressViewWithGrayOverlay()
                }
                else {
                    progressView()
                }
                
            }
        }
    }
    
}


extension ProgressViewModifier {
    
    
    private func progressViewWithGrayOverlay() -> some View {
        
        ZStack {
            
            Color.black
            .frame(height: UIScreen.main.bounds.height + 50)
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            
            progressView()
        }
    }
    
    
    private func progressView() -> some View {
        
        VStack (spacing : 20) {
            
            CustomActivityIndicator(color: self.color, isRunning:  self.$isShowing)
            
            Text(text)
            .foregroundColor(.black)
            .font(.body)
        }
        .frame(width: size.width, height: size.height)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10 )
        .offset(y : -50)
    }
    
    
}


extension View {
    
    func progressView(isShowing: Binding <Bool>, text : String = "Loading...", size : CGSize =  CGSize(width:120, height:120), color : Color = .orange) -> some View{
        
        self.modifier(ProgressViewModifier(isShowing: isShowing, text: text, size: size, color: color))
    }
}
