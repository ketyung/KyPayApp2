//
//  NavigationBackButton.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 18/06/2021.
//

import SwiftUI

struct NavigationBackButton : ViewModifier {
    
    @Environment(\.presentationMode) private var presentation

    let imageName : String
    
    let foregroundColor : Color
    
    let size : CGSize
        
    let additionalAction : (()->Void)?
    
    func body(content : Content) -> some View{
    
        if #available(iOS 14, *) {
            
            content
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem (placement: .navigation)  {
                     image()
                     .foregroundColor(foregroundColor)
                     .onTapGesture {
                         // code to dismiss the view
                        //self.presentation.wrappedValue.dismiss()
                        
                        self.presentation.dismiss()
                        
                        
                        additionalAction?()
                        
                     }
                }
            })
        }
        else {
            content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: image()
               .foregroundColor(foregroundColor)
               .onTapGesture {
                  self.presentation.wrappedValue.dismiss()
                    additionalAction?()
                
               }
            )
        }
    }
    
}

extension NavigationBackButton {
    
    
    @ViewBuilder
    private func image() -> some View{
        
        if let uimg = UIImage(named: imageName){
            
            Image(uiImage: uimg).resizable().frame(width: size.width, height: size.height)
        }
        else {
            
            Image(systemName: imageName).resizable().frame(width: size.width, height: size.height)
        }
    }
}


extension View {
    
    func backButton(
        additionalAction : (()->Void)? = nil,
        imageName : String = "arrow.left.circle",
        foregroundColor : Color = Color(UIColor(hex:"#ff9922ff")!),
        size : CGSize = CGSize(width: 22, height: 22)) -> some View {
        
        return self.modifier(NavigationBackButton(imageName: imageName,
        foregroundColor: foregroundColor, size : size, additionalAction :additionalAction))
    }
}
