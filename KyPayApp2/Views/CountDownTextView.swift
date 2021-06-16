//
//  CountDownTextView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 16/06/2021.
//

import SwiftUI


struct CountDownTextView : View {
    
    private static let timeIntervalToResend : TimeInterval = 120
    
    @State private var timeToCountDown : TimeInterval = CountDownTextView.timeIntervalToResend
  
    var viewModel : OtpTextViewModel
    
    private var timeForDisplay : String {
        
        let timeComponents = self.secondsToHoursMinutesSeconds(seconds: Int(self.timeToCountDown))
        let forDisplay = "\(timeText(from: timeComponents.0)):\(timeText(from: timeComponents.1))"
        
        return forDisplay
    }
    
    init(viewModel : OtpTextViewModel){
        
        self.viewModel = viewModel
        
    }
    
    var body: some View{
        
        Text(timeForDisplay)
        .onAppear{
            DispatchQueue.main.async {
                startCountingDown()
            }
        }
    }
}



extension CountDownTextView {
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int)
    {
        return  ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func timeText(from number: Int) -> String {
        return number < 10 ? "0\(number)" : "\(number)"
    }
    
    
    private func startCountingDown(){
        
       
        if self.timeToCountDown > 0 && self.timeToCountDown < CountDownTextView.timeIntervalToResend {
            
            return
        }
        
        if self.timeToCountDown <= 0 {
            self.timeToCountDown = CountDownTextView.timeIntervalToResend
            self.viewModel.resendEnabled = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {  timer in
           
            if self.timeToCountDown <= 0 {
                timer.invalidate()
                withAnimation {
          
                    self.timeToCountDown = CountDownTextView.timeIntervalToResend
                    self.viewModel.resendEnabled = true
                }
            }
            else {
                self.timeToCountDown -= 1
            }
          
        }
    }
}
