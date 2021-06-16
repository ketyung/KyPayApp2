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
                
                
                Color.black
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
                .opacity(0.35)
                
                
                let w = UIScreen.main.bounds.width - 40
                let h : CGFloat = 400
              
                VStack (spacing: 10){
                    
                    closeButton()
                    
                    content
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .frame(width:w , height: h, alignment: .center)
               
            }
        }
    
    }
    
    
    
    private func closeButton() -> some View {
        
        HStack(spacing:5) {
       
            Spacer()
            .frame(width:2)
            
            Button(action: {
                withAnimation {
                    self.isPresented = false
                }
            }){
                
                Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width:20, height: 20, alignment: .topLeading)
                .foregroundColor(.black)
                
            }
            
            Spacer()
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
