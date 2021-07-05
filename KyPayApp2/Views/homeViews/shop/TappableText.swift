//
//  TappableText.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 06/07/2021.
//

import SwiftUI

struct TappableText : View {
    
    let text : String
    
    var backgroundColor : Color = Theme.commonBgColor
    
    var tappedBackgroundColor : Color = .gray
    
    var foregroundColor : Color = .white
    
    var action : (()->Void)? = nil
    
    @State private var tapped : Bool = false
    
    var body: some View {
        
        Text(text).font(.custom(Theme.fontNameBold, size: 18)).padding().frame(width: 300, height: 40)
        .foregroundColor(foregroundColor).background(tapped ? tappedBackgroundColor : backgroundColor)
        .cornerRadius(6)
        .onTapGesture {
            
            withAnimation{
     
                tapped.toggle()
                action?()
                
                withAnimation(Animation.easeIn(duration: 0.3).delay(0.3) ){
                    
                    tapped.toggle()
                }
            }
        }
    }
}
