//
//  FirstSignInView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUIX

struct FirstSignInView : View {
    
    @EnvironmentObject private var viewModel : UserViewModel
    
    var body : some View {
        
        VStack(spacing: 20){
            
            
            infoTitleView()
            
            Form{
                
                CocoaTextField("First Name", text: $viewModel.firstName )
                .isFirstResponder(true)
                
                TextField("Last Name", text: $viewModel.lastName )
                
                TextField("Email", text: $viewModel.email )
                
                DatePicker("Date Of Birth", selection: $viewModel.dob, displayedComponents: .date)
            }
            .frame(height:400)
            
            
            proceedButton()
            
            Spacer()
        }
    }
}

extension FirstSignInView {
    
    private func infoTitleView() -> some View {
        
        HStack (alignment: .top,spacing: 10){
            
            Image(systemName: "info.circle.fill")
            .resizable()
            .frame(width:26, height: 26)
            .foregroundColor(.orange)
            
            Text("This is your first sign in. Please complete some info below :")
            .font(.headline)
            
        }
        .padding()
    }
    
    
    private func proceedButton() -> some View {
        
        Button(action: {
            
        }){
            
            Text("Proceed")
        }
    }
}
