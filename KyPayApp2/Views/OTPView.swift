//
//  OTPView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI
import SwiftUIX
import Combine

struct OTPView : View {
  
    @EnvironmentObject private var userViewModel : UserViewModel
 
    @EnvironmentObject private var loginViewModel : LoginDataViewModel
 
    @ObservedObject private var viewModel = OtpTextViewModel()
    
    private static let timeIntervalToResend : TimeInterval = 120
    
    @State private var timeToCountDown : TimeInterval = OTPView.timeIntervalToResend
    
    @State private var resendEnabled : Bool = false
    
    @State private var invalidOtpAlertPresented : Bool = false
    
    @State private var invalidOtpMessage : String = "Invalid Verification Code!!"
    
    @State private var pushToFirstSignIn : Bool = false
    
    @State private var pushToHome : Bool = false
    
    @State private var activityIndicatorPresented : Bool = false
    
    private var timeForDisplay : String {
        
        let timeComponents = self.secondsToHoursMinutesSeconds(seconds: Int(self.timeToCountDown))
        let forDisplay = "\(timeText(from: timeComponents.0)):\(timeText(from: timeComponents.1))"
        
        return forDisplay
    }
    
    var body : some View {
        
        NavigationView {
      
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
            
            otpTextFields()
            

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
        .onAppear{
            
            startCountingDown()
        }
     
    }
}


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
        .keyboardType(.decimalPad)
        .font(UIFont.boldSystemFont(ofSize: 30))
        .isFirstResponder(isFirstResponder)
        .width(w)
        .height(w)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .background(Color.white)
        
    }
    
    private func limitText(bind text : Binding<String>, upper: Int = 1 ) {
        if text.wrappedValue.count > upper {
            text.wrappedValue = String(text.wrappedValue.prefix(upper))
           // print("text.wt::\(text.wrappedValue)")
        }
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
                
                
            })
        }
        else {
            
            invalidOtpMessage = "Invalid Verification Code!!"
            self.invalidOtpAlertPresented = true
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
        .hidden(!resendEnabled)
        
       
    }
    
    
    @ViewBuilder
    private func resendText() -> some View {
        
        if resendEnabled {
            
            Button(action: {
                
                self.resendEnabled = false
            }){
                
                Text("Resend")
            }
        }
        else {
     
            Text("Code will be resent after \(timeForDisplay)")
         
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


extension OTPView {
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int)
    {
        return  ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func timeText(from number: Int) -> String {
        return number < 10 ? "0\(number)" : "\(number)"
    }
    
    
    private func startCountingDown(){
        
       
        if self.timeToCountDown > 0 && self.timeToCountDown < OTPView.timeIntervalToResend {
            
            return
        }
        
        if self.timeToCountDown <= 0 {
            self.timeToCountDown = OTPView.timeIntervalToResend
            self.resendEnabled = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
           
            if self.timeToCountDown <= 0 {
                timer.invalidate()
                withAnimation {
          
                    self.timeToCountDown = OTPView.timeIntervalToResend
                    self.resendEnabled = true
                }
            }
            else {
                self.timeToCountDown -= 1
            }
          
        }
    }
}
