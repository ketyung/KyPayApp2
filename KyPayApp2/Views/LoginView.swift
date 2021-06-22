//
//  LogView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI
import SwiftUIX

struct LoginView : View {
    
    @EnvironmentObject private var viewModel : PhoneInputViewModel
    
    @State private var signInButtonDisabled : Bool = false
    
    @State private var errorAlertPresented : Bool = false
    
    @State private var errorMessage : String = ""
    
    @State private var yOffset : CGFloat = 0
    
    
    var body: some View {
        
        if $viewModel.isOTPViewPresented.wrappedValue {
            
            OTPView()
            .onAppear{
                 
                presentSignInErrorIfAny()
            }
        }
        else {
    
            loginView().offset(y: yOffset)
            .animation(.easeInOut(duration: 0.65))
        }
     
    }
}


extension LoginView {
    
    private func loginView() -> some View {
        
        VStack{
            
            Spacer()
            .frame(height:320)
            
            Text("Welcome")
            .font(.custom(Theme.fontNameBold, size:36))
            .foregroundColor(.systemYellow)
            
            signInPanel()
            
            Spacer()
            .frame(height:30)
            
            signInButton()
            .disabled(signInButtonDisabled)
            
            dismissKeyboardButton()
         
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height + 200)
        .background(Color(UIColor(hex: "#8899aaff")!))
        .edgesIgnoringSafeArea(.all)
        .bottomSheet(isPresented: $viewModel.isCountryPickerPresented, height: UIScreen.main.bounds.height - 120, showGrayOverlay: true){
            
            
            CountryCodePickerUI(viewModel: viewModel, textFont: .custom(Theme.fontName, size: 16))
            
        }
        .alert(isPresented: $errorAlertPresented){
            
            Alert(title: Text("Error!"),message:Text(errorMessage))
        }
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
        .neumo()
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
                .foregroundColor(.black)
                .font(Font.system(size: 18, design: .rounded))
                .lineLimit(1)
            
            }
            
        }
    
    }
    
}


extension LoginView {
    
    
    private func phoneTextField() -> some View {
    
        
        CocoaTextField("Phone Number", text: $viewModel.enteredPhoneNumber)
        .foregroundColor(.black)
        .keyboardType(.numberPad)
        .font(UIFont.boldSystemFont(ofSize: 24))
        .isFirstResponder(viewModel.phoneNumberIsFirstResponder)
        .width(200)
        .height(20)
        .padding()
        .background(Color.white)
        .onTapGesture {
            viewModel.phoneNumberIsFirstResponder = true
        }
         
    }

    
    
    private func signInButton() -> some View {
        
        Button(action: {
            
            self.signInButtonAction()
            
        }){
            
            Text("Continue".localized)
            .foregroundColor(Color(UIColor(hex:"#333333ff")!))
            .font(.custom(Theme.fontName, size: 20))
        }
        
    }
    
    private func dismissKeyboardButton() -> some View {
        
        HStack(spacing:20) {
       
            Spacer()
            .frame(width:5)
            
            Button(action: {
                withAnimation {
                    
                    viewModel.phoneNumberIsFirstResponder = false
                    yOffset = 0
                }
            }){
                
                Image(systemName: "arrowtriangle.down.circle.fill")
                .resizable()
                .frame(width:20, height: 20, alignment: .topLeading)
                .foregroundColor(.white)
                
            }
            
            Spacer()
        }
        .hidden(!viewModel.phoneNumberIsFirstResponder)
    }
    
}


extension LoginView {
    
    private func signInButtonAction(){
        
        viewModel.phoneNumberIsFirstResponder = false
        
        let phoneNum = "\(viewModel.selectedCountry?.dialCode ?? "+60")\(viewModel.enteredPhoneNumber)"
        
        if phoneNum.isValidPhone() {
       
            viewModel.sendOTP(phoneNumber: phoneNum, completion: {
                
                err in
                
                if let err = err {
                    
                    self.errorMessage = err.localizedDescription
                    self.errorAlertPresented = true 
                    return
                }
          
                signInButtonDisabled = true
                
               
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    
                    self.signInButtonDisabled = false
                })

            })
            
        }
        else {
            withAnimation {
       
                self.errorAlertPresented = true
                self.errorMessage = "Invalid Phone Number !"
            }
        }
        
       
    }
    
    
    private func selectedCountryImage() -> UIImage? {
        
        if let country = viewModel.selectedCountry {
            
            return country.flag
        }
        
        return UIImage(named: "CountryPickerView.bundle/Images/MY")
    }
    
}

extension LoginView {
    
    private func presentSignInErrorIfAny(){
        
        if viewModel.failedSigniningIn, let err = viewModel.signInError {
            
            viewModel.failedSigniningIn = false
            self.errorMessage = err.localizedDescription
            viewModel.signInError = nil
            self.errorAlertPresented = true
        }
    }
}

