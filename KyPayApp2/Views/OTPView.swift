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
    
    @ObservedObject private var viewModel = OtpTextViewModel()
    
    @State private var timeToCountDown : TimeInterval = 120
   
    private var timeForDisplay : String {
        
        let timeComponents = self.secondsToHoursMinutesSeconds(seconds: Int(self.timeToCountDown))
        let forDisplay = "\(timeText(from: timeComponents.0)):\(timeText(from: timeComponents.1))"
        
        return forDisplay
    }
    
    var body : some View {
        
        VStack(spacing:20){
            
            Spacer()
            .frame(height:100)
            
            Text("Please enter the 6-digit verification code below:")
            .font(.system(size: 20))
            .frame(width: 300)
            
            otpTextFields()
            
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                
                Text("Proceed")
            }
            
            Spacer()
            .frame(height:30)
            
            Text("Code will be resent after \(timeForDisplay)")
            
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
            print("text.wt::\(text.wrappedValue)")
        }
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
        
       
        if self.timeToCountDown > 0 && self.timeToCountDown < 20 {
            
            return
        }
        
        if self.timeToCountDown <= 0 {
            self.timeToCountDown = 20
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
           
            
            if self.timeToCountDown <= 0 {
                timer.invalidate()
            }
            else {
                self.timeToCountDown -= 1
            }
          
        }
    }
}
