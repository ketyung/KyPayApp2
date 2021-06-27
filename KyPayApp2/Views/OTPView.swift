//
//  OTPView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUIX

struct OTPView : View {
  
    @EnvironmentObject private var userViewModel : UserViewModel
 
    @EnvironmentObject private var phoneInputViewModel : PhoneInputViewModel
 
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
            .frame(width: UIScreen.main.bounds.width - 20, height: 400)
            .cornerRadius(10)
            .padding(.top, 10).padding(.bottom, 30).padding(.leading, 20).padding(.trailing, 20)
    
        }
        .alert(isPresented: $invalidOtpAlertPresented){
            Alert(title: Text("Oppps!"),message:Text(invalidOtpMessage))
        }
        .progressView(isShowing: $activityIndicatorPresented, text : "Signing in ...")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension OTPView {
    
    
    private func otpScreenView() -> some View {
        
        VStack(spacing:20){
                    
            Spacer()
            .frame(height:30)

            Text("Please enter the 6-digit\nverification code below:".localized)
            .fixedSize(horizontal: false, vertical: true)
            .lineLimit(2)
            .font(.custom(Theme.fontName, size: 20))
            .frame(width: 300)
            
            otpTextField()
            
            proceedButton()
            
            resendText()
            
            Spacer()
            .frame(height:30)
            
            closeButton()
          
            homeScreenNavLink()
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor(hex:"#ccddddff")!))
     
    }
}


extension OTPView {
    
    
    private func otpTextField() -> some View {
        
        CocoaTextField("", text: $viewModel.text)
        .font(UIFont.boldSystemFont(ofSize: 30))
        .isFirstResponder(true)
        .keyboardType(.numberPad)
        .textContentType(.oneTimeCode)
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
            
            Text("Proceed".localized)
        }
        
    }
    
    private func proceed() {
        
        if viewModel.text.count == 6 {
            
            
            activityIndicatorPresented = true
            userViewModel.signIn(verificationCode: viewModel.text, completion: {
                
                firstSignIn , err in
                
                if let err = err {
                    
                    DispatchQueue.main.async {
                 
                        phoneInputViewModel.failedSigniningIn = true
                        phoneInputViewModel.signInError = err
                        self.activityIndicatorPresented = false
                        self.invalidOtpMessage = err.localizedDescription
                        self.invalidOtpAlertPresented = true
                     
                    }
                    
                    return
                }
                
                
    
                DispatchQueue.main.async {
        
                    self.determineScreenToPush(firstSignIn)
                }
                        
            })
        }
        else {
            
            invalidOtpMessage = "Invalid Verification Code!!".localized
            self.invalidOtpAlertPresented = true
        }
    }
    
    
    private func determineScreenToPush( _ firstSignIn : Bool ){
        
        withAnimation{
            
            self.userViewModel.firstSignIn = firstSignIn
            
            
            self.pushToHome = true

            self.activityIndicatorPresented = false
            phoneInputViewModel.removeAllUnneeded()
      
        }
    }
    
    
    private func closeButton() -> some View {
        
        HStack(spacing:20) {
       
            Spacer()
            .frame(width:5)
            
            Button(action: {
                withAnimation {
                    phoneInputViewModel.isOTPViewPresented = false
                }
            }){
                
                Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width:30, height: 30, alignment: .topLeading)
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
            
                Text("Code will be resent after".localized)
                CountDownTextView(viewModel: viewModel)
            }
            
        }
        
    }
}

extension OTPView {
    
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
