//
//  CountDownTextView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 16/06/2021.
//

import SwiftUI


struct CountDownTextView : View {
    
    private static let timeIntervalToResend : TimeInterval = 10
    
    @State private var timeToCountDown : TimeInterval = CountDownTextView.timeIntervalToResend
  
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
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
        .padding(4)
        .background(.orange)
        .foregroundColor(.white)
        .cornerRadius(6)
        .onReceive(timer) { _ in
            
            countingDown()
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
    
    
    private func countingDown(){
        
       
        if self.timeToCountDown > 0 && self.timeToCountDown <= CountDownTextView.timeIntervalToResend {
            
            self.timeToCountDown -= 1
     
            return
        }
        
        if self.timeToCountDown <= 0 {
            withAnimation {
      
                self.timeToCountDown = CountDownTextView.timeIntervalToResend
                self.viewModel.resendEnabled = true
                self.timer.upstream.connect().cancel()
            }
        }
     
        
    }
}
