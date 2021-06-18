//
//  SendView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI


struct SendView : View {
    
    
    @ObservedObject private var dataInputViewModel = LoginDataViewModel()
   
    
    var body: some View {
        
        VStack(alignment: .leading, spacing:20) {
            
            Spacer()
            .frame(height:30)
            
            Text("Send Money")
            .font(.custom(Theme.fontNameBold, size: 40))
            
            Spacer()
            .frame(height:30)
            
            Text("Mobile Phone")
            .font(.custom(Theme.fontName, size: 20))
            .foregroundColor(Color(UIColor(hex:"#866200ff")!))
            
            
            phoneView()
            
            
            Spacer()
        }
        .padding()
        .popOver(isPresented: $dataInputViewModel.isCountryPickerPresented){
        
            CountryCodePickerUI(viewModel: dataInputViewModel, textFont: .custom(Theme.fontName, size: 15))
        }
        
    }
}

extension SendView {
    
    private func phoneView() -> some View {
        
        HStack(alignment: .center,spacing:10) {
            
            Spacer().frame(width:10)
            
            phoneViewWithDialCode()
           
            contactButton()
            
            Spacer()
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 10 ,height: 30)
    }
    
    private func phoneViewWithDialCode() -> some View {

        HStack(spacing:2) {
    
            dialCodeButton()
            
            phoneTextField()

        }
        .frame(height: 30)
  
    }
    
    
    private func phoneTextField() -> some View {
    
        TextField("Phone Number", text: $dataInputViewModel.enteredPhoneNumber)
        .foregroundColor(.black)
        .background(Color.white)
        .keyboardType(.decimalPad)
        .frame(width: 200, height: 24)
        .font(.custom(Theme.fontNameBold, size: 26))
        .overlay(VStack{Divider().offset(x: 0, y: 28).foregroundColor(.blue)})
    
    }
    
}


extension SendView {

    @ViewBuilder
    private func dialCodeButton() -> some View {
        
        Button(action: {
            
            withAnimation{
           
                dataInputViewModel.isCountryPickerPresented = true
            }
            
        }){
            
            Text(dataInputViewModel.selectedCountry?.dialCode ?? "+60")
            .foregroundColor(.black)
            .font(Font.system(size: 20, design: .rounded))
            .frame(width: 60, height: 24)
            .lineLimit(1)
   
        }
        
       
    }
    
    private func selectedCountryImage() -> UIImage? {
        
        if let country = dataInputViewModel.selectedCountry {
            
            return country.flag
        }
        
        return UIImage(named: "CountryPickerView.bundle/Images/MY")
    }
    

}

extension SendView {
    
    
    private func contactButton() -> some View {
        
        Button(action: {}){
            
            ZStack {
                
                Circle().fill(Color(UIColor(hex:"#5566bbff")!)).frame(width: 40)
            
                Image(systemName: "person.3.fill")
                .foregroundColor(.white)
            }
                
            
        }
    }
}
