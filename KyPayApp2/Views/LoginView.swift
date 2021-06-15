//
//  LogView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI
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
        .edgesIgnoringSafeArea(.all)
        .bottomSheet(isPresented: $viewModel.isCountryPickerPresented, height: UIScreen.main.bounds.height - 100, showGrayOverlay: true){
            
            
            CountryCodePickerUI()
            
        }
        .bottomSheet(isPresented: $viewModel.isOTPViewPresented, height: UIScreen.main.bounds.height + 50, showGrayOverlay: true, content: {
            
            OTPView()
        })
        
    }
}


extension LoginView {
    
    private func signInPanel() -> some View {
        
        HStack(spacing:10) {
            
            flagButton()
            
            phoneTextField()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 10, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color(UIColor(hex: "#334455ff")!))
        .cornerRadius(6)
       
    }
    
    
    
    @ViewBuilder
    private func flagButton() -> some View {
        
        Button(action: {
            
            viewModel.isCountryPickerPresented = true 
            
        }){
            
            HStack {
       
                if let img = selectedCountryImage() {
                    
                    let w : CGFloat = 24
                    let h = img.size.height / img.size.width * w
            
                    Image(uiImage: img)
                    .resizable()
                    .frame(width: w, height: h, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                }
       
                Text(viewModel.selectedCountry?.dialCode ?? "+60")
                .foregroundColor(.white)
                .font(Font.system(size: 18, design: .rounded))
                .lineLimit(1)
            
            }
       
                
                
            
        }
        
       
    }
    
}


extension LoginView {
    
    
    private func phoneTextField() -> some View {
    
        
        CocoaTextField("Phone Number", text: $viewModel.enteredPhoneNumber)
        .font(UIFont.boldSystemFont(ofSize: 24))
        .isFirstResponder(viewModel.phoneNumberIsFirstResponder)
        .width(200)
        .height(20)
        .padding()
        .foregroundColor(.black)
        .background(Color.white)
        .keyboardType(.decimalPad)
        .onReceive(Just(viewModel.enteredPhoneNumber)) { _ in
            
            if !viewModel.phoneNumberIsFirstResponder {
                viewModel.phoneNumberIsFirstResponder = true
            }
            limitPhoneNumber()
            
        }

    }
    
    
    
    private func signInButton() -> some View {
        
        Button(action: {
            
            viewModel.phoneNumberIsFirstResponder = false
            
            viewModel.sendOTP(phoneNumber: "\(viewModel.selectedCountry?.dialCode ?? "+60")\(viewModel.enteredPhoneNumber)")
            
        }){
            
            Text("Continue")
            .foregroundColor(.white)
            .font(Font.system(size: 20, design: .rounded))
              
        }
    }
}


extension LoginView {
    
    
    private func selectedCountryImage() -> UIImage? {
        
        if let country = viewModel.selectedCountry {
            
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

