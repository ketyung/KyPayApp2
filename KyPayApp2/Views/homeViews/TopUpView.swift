//
//  TopUpView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import SwiftUI


struct TopUpView : View {
    
    @Binding var isPresented : Bool
    
    var body: some View {
        
        VStack(spacing: 20){
            
            closeButton()
            
            Spacer().frame(height:30)
            

            Text("Available top-up methods".localized)
            .font(.custom(Theme.fontName, size: 18))
            .padding()
            .neumo()
            
            Spacer().frame(height:20)
            
            
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                
                
                HStack(spacing:20) {
                    
                    Image(systemName: "creditcard.circle")
                    .resizable()
                    .frame(width:30, height: 30)
                    .foregroundColor(.green)
                
                    Text("Cards".localized)
                    .font(.custom(Theme.fontName, size: 16))
                    
                    Spacer()
                }.padding()
                
                
                
                HStack(spacing:20)  {
                    
                    Image(systemName: "house.circle")
                    .resizable()
                    .frame(width:30, height: 30)
                    .foregroundColor(.orange)
                
                    Text("Online Banking".localized)
                    .font(.custom(Theme.fontName, size: 16))
                    
                    Spacer()
                      
                }.padding()
                
            }
            
            
        }.padding()
    }
}


extension TopUpView {
    
    
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
