//
//  FirstSignInView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUIX

struct FirstSignInView : View {
    
    
    @EnvironmentObject private var viewModel : UserViewModel
    
    @EnvironmentObject private var phoneInputViewModel : PhoneInputViewModel
 
    
    @State private var errorPresented : Bool = false
    
    @State private var errorMessage : String?
    
    @State private var pushToHome : Bool = false
    
    var body : some View {
        
        VStack(spacing: 20){
            
            
            infoTitleView()
            
            Form{
                
                TextField("First Name", text: $viewModel.firstName )
                
                TextField("Last Name", text: $viewModel.lastName )
                   
                TextField("Email", text: $viewModel.email )
                    
    
                DatePicker("Date Of Birth", selection: $viewModel.dob, displayedComponents: .date)
            }
            .frame(height:400)
            
            
            proceedButton()
            
            Spacer()
            
        }
        .popOver(isPresented: $errorPresented, content: {
            
            Common.errorAlertView(message: errorMessage ?? "")
        })
        
     //   .alert(isPresented: $errorPresented){ Alert(title: Text("Oppps!"),message:Text(errorMessage ?? ""))}
      
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
            
            
            viewModel.add(country: phoneInputViewModel.selectedCountry ?? Country(code: Common.defaultCountry) ,completion: {
                
                err in
                
                if let err = err {
               
                    withAnimation{
                        
                        self.errorMessage = err.localizedDescription
                        self.errorPresented = true
                    }
                    return
                }
                
                DispatchQueue.main.async {
              
                    phoneInputViewModel.removeAllUnneeded()
              
                    withAnimation{
                          
                        viewModel.firstSignIn = false
                    }
                }
                
              
                
               
            })
        }){
            if viewModel.showingProgressIndicator {
                
                ActivityIndicator()
            }
            else {
     
                Text("Proceed".localized)
         
            }
        }
    }
    
    
}
