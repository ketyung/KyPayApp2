//
//  LogView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI
import CountryPickerView
import Combine
import SwiftUIX

struct LoginView : View {
    
    @EnvironmentObject private var viewModel : LoginDataViewModel
    
    
    var body: some View {
        
        VStack{
            
            Spacer()
            .frame(height:250)
            
            signInPanel()
            
            Spacer()
            .frame(height:30)
            
            signInButton()
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        .background(Color(UIColor(hex: "#3388AAff")!))
    }
}


extension LoginView {
    
    private func signInPanel() -> some View {
        
        HStack(spacing:2) {
            
            flagButton()
            
            phoneTextField()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 40, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(UIColor(hex: "#334455ff")!))
        .cornerRadius(10)
       
    }
    
    
    
    @ViewBuilder
    private func flagButton() -> some View {
        
        Button(action: {}){
            
       
            if let img = selectedCountryImage() {
                
                let w : CGFloat = 30
                let h = img.size.height / img.size.width * w
           
                Image(uiImage: img)
                .resizable()
                .frame(width: w, height: h, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
               
            }
            else {
                
                Text("+60")
                .foregroundColor(.white)
                    .font(Font.system(size: 26, design: .rounded))
                
            }
         
        }
        
       
    }
    
}


extension LoginView {
    
    
    private func phoneTextField() -> some View {
    
        
        CocoaTextField("Phone Number", text: $viewModel.enteredPhoneNumber)
        .isFirstResponder(true)
        .borderStyle(.roundedRect)
        .width(220)
        .height(50)
        .font(.system(size: 50))
        .foregroundColor(.black)
        .background(Color.white)
        .padding()
        .keyboardType(.decimalPad)
        .onReceive(Just(viewModel.enteredPhoneNumber)) { _ in limitPhoneNumber() }

    }
    
    
    
    private func signInButton() -> some View {
        
        Button(action: {
            
        }){
            
            Text("Sign In")
            .foregroundColor(.white)
            .font(Font.system(size: 20, design: .rounded))
              
        }
    }
}


extension LoginView {
    
    
    private func selectedCountryImage() -> UIImage? {
        
        if let country = viewModel.selectedCounrty {
            
            return country.flag
        }
        
        return UIImage(named: "CountryPickerView.bundle/Images/MY")
    }
    
    
    private func limitPhoneNumber(_ upper: Int = 10 ) {
        if viewModel.enteredPhoneNumber.count > upper {
            viewModel.enteredPhoneNumber = String(viewModel.enteredPhoneNumber.prefix(upper))
        }
    }
    
    
}

