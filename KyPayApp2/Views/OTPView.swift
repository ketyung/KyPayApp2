//
//  OTPView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI

struct OTPView : View {
  
    @EnvironmentObject private var userViewModel : UserViewModel
 
    @EnvironmentObject private var loginViewModel : LoginDataViewModel
 
    @ObservedObject private var viewModel = OtpTextViewModel()
    
    @State private var invalidOtpAlertPresented : Bool = false
    
    @State private var invalidOtpMessage : String = "Invalid Verification Code!!"
    
    @State private var pushToFirstSignIn : Bool = false
    
    @State private var pushToHome : Bool = false
    
    @State private var activityIndicatorPresented : Bool = false
    
    
    var body : some View {
        
        NavigationView {
           // let _ = print("otp.presented!")
            otpScreenView()
        }
        .alert(isPresented: $invalidOtpAlertPresented){
            Alert(title: Text("Oppps!"),message:Text(invalidOtpMessage))
        }
        .progressView(isShowing: $activityIndicatorPresented, text : "Signing in ...")
        .navigationBarBackButtonHidden(true)
    
    }
}

extension OTPView {
    
    
    private func otpScreenView() -> some View {
        
        VStack(spacing:20){
            
            
            Spacer()
            .frame(height:30)

            closeButton()
          
            
            Text("Please enter the 6-digit verification code below:")
            .font(.system(size: 20))
            .frame(width: 300)
            
            //otpTextFields()
            
            otpTextField()
            
            proceedButton()
            
            Spacer()
            .frame(height:30)
            
            resendText()
            
            firstScreenNavLink()
            homeScreenNavLink()
            
            Spacer()
        }
        .background(Color(UIColor(hex:"#DDDDDDff")!))
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.all)
       
     
    }
}


extension OTPView {
    
    
    private func otpTextField() -> some View {
        
        TextField("", text: $viewModel.text)
        .keyboardType(.numberPad)
        .textContentType(.oneTimeCode)
        .font(.custom(Theme.fontName, size: 30), weight: .bold)
        .frame(width: 200, height: 40)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .background(Color.white)
        
       
    }
    
}



extension OTPView {
    
    private func proceedButton() -> some View {
        
        Button(action: {
            
            proceed()
            
        }){
            
            Text("Proceed")
        }
        
    }
    
    private func proceed() {
        
        if viewModel.text.count == 6 {
            
            
            activityIndicatorPresented = true
            userViewModel.signIn(verificationCode: viewModel.text, completion: {
                
                firstSignIn , err in
                
                if let err = err {
                    
                    invalidOtpMessage = err.localizedDescription
                    self.invalidOtpAlertPresented = true
                    self.activityIndicatorPresented = false
                    
                    return
                }
                
                
    
                DispatchQueue.main.async {
        
                    self.determineScreenToPush(firstSignIn)
                }
                        
            })
        }
        else {
            
            invalidOtpMessage = "Invalid Verification Code!!"
            self.invalidOtpAlertPresented = true
        }
    }
    
    
    private func determineScreenToPush( _ firstSignIn : Bool ){
        
        withAnimation{
  
            if firstSignIn {
                
                self.pushToFirstSignIn = true
                self.pushToHome = false
                
            }
            else {
            
                self.pushToFirstSignIn = false
                self.pushToHome = true
            }
            
            self.activityIndicatorPresented = false
            loginViewModel.removeAllUnneeded()
      
        }
    }
    
    
    private func closeButton() -> some View {
        
        HStack(spacing:20) {
       
            Spacer()
            .frame(width:5)
            
            Button(action: {
                withAnimation {
                    loginViewModel.isOTPViewPresented = false
                }
            }){
                
                Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width:20, height: 20, alignment: .topLeading)
                .foregroundColor(.black)
                
            }
            
            Spacer()
        }
        .hidden(!viewModel.resendEnabled)
        
       
    }
    
    
    @ViewBuilder
    private func resendText() -> some View {
        
        if viewModel.resendEnabled {
            
            Button(action: {
                
                self.viewModel.resendEnabled = false
            }){
                
                Text("Resend")
            }
        }
        else {
     
            HStack{
            
                Text("Code will be resent after")
                CountDownTextView(viewModel: viewModel)
            }
            
        }
        
    }
}

extension OTPView {
    
    private func firstScreenNavLink() -> some View {
        
        NavigationLink(destination: FirstSignInView(), isActive : $pushToFirstSignIn){}.hidden(true)
    }
    
    
    private func homeScreenNavLink() -> some View {
        
        NavigationLink(destination: ContentView(), isActive : $pushToHome){}.hidden(true)
    }
}





/** No More needed - commented out
extension OTPView {
    
    
    private func otpTextFields() -> some View {
        
        HStack (spacing: 10){
            
            textField(bind: $viewModel.number1, isFirstResponder: (viewModel.focusableIndex == 0))
            
            textField(bind: $viewModel.number2, isFirstResponder: (viewModel.focusableIndex == 1))
                
            textField(bind: $viewModel.number3, isFirstResponder: (viewModel.focusableIndex == 2))
            textField(bind: $viewModel.number4, isFirstResponder: (viewModel.focusableIndex == 3))
            textField(bind: $viewModel.number5, isFirstResponder: (viewModel.focusableIndex == 4))
            textField(bind: $viewModel.number6, isFirstResponder: (viewModel.focusableIndex == 5))
         
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width , height: 100, alignment: .center)
    }
    
    
    @ViewBuilder
    private func textField( bind text : Binding<String>, isFirstResponder : Bool = false ) ->some View{
    
        let w : CGFloat = 40
        
        CocoaTextField("", text: text)
        .keyboardType(.numberPad)
        .font(UIFont.boldSystemFont(ofSize: 30))
        .isFirstResponder(isFirstResponder)
        .width(w)
        .height(w)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .background(Color.white)
        
    }
    
}*/
