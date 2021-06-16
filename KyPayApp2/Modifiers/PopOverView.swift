//
//  TopBarPopOverModifier.swift
//  SwiftUIAvFX
//
//  Created by Chee Ket Yung on 29/04/2021.
//

import SwiftUI

struct PopOverView <Content: View>: View {
    
    
    @Binding var isPresented : Bool

    private let content: Content
    
    private let viewXOffset : CGFloat
    
    private let viewXOffsetMultiplier : CGFloat
    
    private let yOffset : CGFloat
    
    init(isPresented : Binding <Bool>, @ViewBuilder content: () -> Content, notchXOffset : CGFloat = 0,
         viewXOffset : CGFloat = 0, viewXOffsetMultiplier : CGFloat = 0, yOffset : CGFloat = 0 ){
        
        self._isPresented = isPresented
        self.content = content()
        self.viewXOffset = viewXOffset
        self.viewXOffsetMultiplier = viewXOffsetMultiplier
        self.yOffset = yOffset
    }
   
    var body: some View {
        
        ZStack {
            if isPresented {
                
                let w = UIScreen.main.bounds.width - 40
              //  let x = (UIScreen.main.bounds.width - w) / 2
      
                let h : CGFloat = 400
                //let y = (UIScreen.main.bounds.height - h) / 2
      
                VStack (spacing: 10){
                    content
                }
                .padding()
                .frame(width:w , height: h, alignment: .center)
                .background(Color(UIColor(hex: "#DDDDDDff")!))
                .cornerRadius(10)
          
            }
        }
    
    }
    
}



public extension View {
    func popOver<Content: View>(
        isPresented: Binding<Bool>,  notchXOffset : CGFloat = 0, viewXOffset : CGFloat = 0,
        viewXOffsetMultiplier : CGFloat = 0, yOffset : CGFloat = 0,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            PopOverView(isPresented: isPresented,content: content, notchXOffset : notchXOffset, viewXOffset : viewXOffset, viewXOffsetMultiplier : viewXOffsetMultiplier, yOffset : yOffset)
        }
    }
}
