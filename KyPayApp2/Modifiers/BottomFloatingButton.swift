//
//  BottomFloatingButton.swift
//  SwiftUIPdfApp
//
//  Created by Chee Ket Yung on 20/02/2021.
//

import SwiftUI

struct BottomFloatingButton : ViewModifier {
    
    var isPresented : Bool
    
    var action : () -> Void?
    
    let backgroundColor : Color = Color(UIColor(hex:"#66BB33ff")!)
    
    let size : CGSize = CGSize(width: 60, height: 60)
    
    let imageName : String
    
    let yOffSet : CGFloat = 240
    
    @ViewBuilder
    func body(content: Content) -> some View {
 
        ZStack {
            
            content
            
            if ( isPresented ){
            
                GeometryReader { geo in
          
                    floatingButton()
                    .position(x: geo.size.width - size.width , y: geo.size.height - yOffSet )
                    
                }
               
            }
            
        }
        
    }
    
}


extension BottomFloatingButton {
    
    private func floatingButton () -> some View {
       
        Button (action: {
          
            self.action()
            
        }, label: {
      
            ZStack {
                
                Circle()
                .fill(backgroundColor)
                .frame(width: size.width, height:size.height)
                
               
                image().foregroundColor(.white)
            }
            .padding()
          
        })
       
    }
}


extension BottomFloatingButton {
    
    
    @ViewBuilder
    private func image() -> some View{
        
        if let uimg = UIImage(named: imageName){
            
            Image(uiImage: uimg).resizable().frame(width: size.width / 2, height: size.height / 2)
        }
        else {
            
            Image(systemName: imageName).resizable().frame(width: size.width / 2 , height: size.height / 2)
        }
    }
}

extension View {
    
    func bottomFloatingButton( isPresented : Bool,action : @escaping () -> Void?,  imageName : String = "arrow.right.circle" ) -> some View {
        
        self.modifier( BottomFloatingButton(isPresented : isPresented, action: action, imageName: imageName))
    }
}
