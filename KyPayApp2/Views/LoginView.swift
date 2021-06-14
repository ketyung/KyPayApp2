//
//  LogView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI
import CountryPickerView
import Combine

struct LoginView : View {
    
    @EnvironmentObject private var viewModel : LoginDataViewModel
    
    
    var body: some View {
        
        VStack{
            
            Spacer()
            .frame(height:250)
            
            HStack(spacing:10) {
                
                if let img = selectedCountryImage() {
                    
                    let w : CGFloat = 30
                    let h = img.size.height / img.size.width * w
               
                    Image(uiImage: img)
                    .resizable()
                    .frame(width: w, height: h, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                   
                }
                
                TextField("Phone Number", text: $viewModel.enteredPhoneNumber)
                .foregroundColor(.black)
                .background(Color.white)
                .padding()
                .keyboardType(.decimalPad)
                .font(Font.system(size: 36, design: .default))
                .frame(width:300)
                .onReceive(Just(viewModel.enteredPhoneNumber)) { _ in limitPhoneNumber() }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color(UIColor(hex: "#132255ff")!))
            .cornerRadius(10)
           
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        .background(Color(UIColor(hex: "#3388AAff")!))
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

