//
//  HomeView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct HomeView : View {

    @EnvironmentObject private var viewModel : UserViewModel
    
    var body : some View {
        
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            
            Spacer().frame(height: 50)
            
            welcomePanel()
            
            buttonsScrollView()
            
            Spacer()
        }
        .padding()
        .frame(width:UIScreen.main.bounds.width )
    }
    
}



extension HomeView {
    
    
    private func welcomePanel() -> some View {
        
        VStack {
       
            Text("Welcome Back")
            .font(.subheadline)
            
            Text("\(viewModel.firstName) \(viewModel.lastName)")
            .font(.headline)
           
        }
        .padding(6)
        .frame(width: UIScreen.main.bounds.width - 100)
        
    }
}


extension HomeView {
    
    private func buttonsScrollView() -> some View {
        
        ScrollView(.horizontal, showsIndicators: false ){
            
            HStack {
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    
                    buttonView(imageOne: "wallet", imageTwo: "plus.circle", text: "Top Up")
                }
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    
                    buttonView(color: .orange, imageOne: "dollarsign.circle.fill", imageTwo: "arrow.right", text: "Send Money")
                }
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                    
                    buttonView(color: .purple, imageOne: "arrow.left", imageOneSize:  CGSize(width:24, height:24),
                    imageTwo: "dollarsign.circle.fill", imageTwoSize:  CGSize(width:40, height:40), text: "Request Money")
                }
                
            }
        }
    }
    
    
    
    
    
    
    private func buttonView ( color : Color = .green,
                              imageOne : String,
                              imageOneSize : CGSize = CGSize(width:40, height: 40),
                              
                              imageTwo : String,
                              
                              imageTwoSize : CGSize = CGSize(width:24, height: 24),
                              
                              text : String ) -> some View{
        
        
        ZStack {
      
            Rectangle()
            .fill(color)
            .frame(width: 120, height: 80)
            .cornerRadius(10)
            .padding(4)
                
            VStack {
            
                
                HStack {
                
                    if let img = UIImage(named: imageOne){
                        
                        Image(uiImage: img)
                        .resizable()
                        .frame(width:imageOneSize.width, height: imageOneSize.height)
                    }
                    else {
                        
                        Image(systemName: imageOne)
                        .resizable()
                        .frame(width:imageOneSize.width, height: imageOneSize.height)
                       
                    }
                    
                    if let img2 = UIImage(named: imageTwo){
                        
                        Image(uiImage: img2)
                        .resizable()
                        .frame(width:imageTwoSize.width, height: imageTwoSize.height)
                        .foregroundColor(.white)
                        
                    }
                    else {
                        
                        Image(systemName: imageTwo)
                        .resizable()
                        .frame(width:imageTwoSize.width, height: imageTwoSize.height)
                        .foregroundColor(.white)
                        
                    }
                
                }
                
                Text(text)
                .font(.custom("Helvetica Neue", size: 15))
                .foregroundColor(.white)
                
            }
            
            
        }
        
    }
    
    
    
}
