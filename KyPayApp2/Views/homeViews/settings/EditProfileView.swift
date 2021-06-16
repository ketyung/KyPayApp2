//
//  EditProfileView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 16/06/2021.
//

import SwiftUIX
import Combine


struct EditProfileView : View {
    
    @EnvironmentObject private var viewModel : UserViewModel
    
    @State private var userViewModel = UserViewModel()
    
    @State private var isCountryPickerPresented : Bool = false
    
    @State private var selectedCountry : Country?
    
    var body: some View {
        
        profileFormView()
        .onAppear{
            
            userViewModel.loadUser(viewModel.user)
        }
    }
}

extension EditProfileView {
    
    private func infoTitleView() -> some View {
        
        HStack (alignment: .top,spacing: 10){
            
            Image(systemName: "info.circle.fill")
            .resizable()
            .frame(width:26, height: 26)
            .foregroundColor(.orange)
            
            Text("Edit your profile below :")
            .font(.headline)
            
        }
        .padding()
    }
    
    
    private func profileFormView() -> some View {
        
        VStack {
       
            infoTitleView()
            
            Form{
                
                CocoaTextField("First Name", text: $userViewModel.firstName )
                .isFirstResponder(true)
                
                TextField("Last Name", text: $userViewModel.lastName )
                
                phoneView()
                
                TextField("Email", text: $userViewModel.email )
                
                DatePicker("Date Of Birth", selection: $userViewModel.dob, displayedComponents: .date)
            }
            .frame(height:400)
           
            Spacer()
            .frame(minHeight: 300)
        }
        
    }
}


extension EditProfileView {
    
    private func phoneView() -> some View {
        
        HStack(spacing:20) {
            
            flagButton()
            phoneTextField()
            
        }
    }
    
    private func phoneTextField() -> some View {
    
        
        CocoaTextField("Phone Number", text: $userViewModel.phoneNumber)
        .font(UIFont.boldSystemFont(ofSize: 20))
        .width(160)
        .height(20)
        .padding()
        .foregroundColor(.black)
        .background(Color.white)
        .keyboardType(.decimalPad)
        .onReceive(Just($userViewModel.phoneNumber)) { _ in
            
            limitPhoneNumber()
            
        }

    }
    
    private func limitPhoneNumber(_ upper: Int = 10 ) {
        if viewModel.phoneNumber.count > upper {
            viewModel.phoneNumber = String(viewModel.phoneNumber.prefix(upper))
        }
    }
}


extension EditProfileView {
    
    @ViewBuilder
    private func flagButton() -> some View {
        
        Button(action: {
            
            self.isCountryPickerPresented = true
            
        }){
            
            HStack {
       
                if let img = selectedCountryImage() {
                    
                    let w : CGFloat = 30
                    let h = img.size.height / img.size.width * w
            
                    Image(uiImage: img)
                    .resizable()
                    .frame(width: w, height: h, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                }
       
                Text(selectedCountry?.dialCode ?? "+60")
                .foregroundColor(.black)
                .font(Font.system(size: 18, design: .rounded))
                .lineLimit(1)
            
            }
            
        }
        
       
    }
    
    private func selectedCountryImage() -> UIImage? {
        
        if let country = selectedCountry {
            
            return country.flag
        }
        
        return UIImage(named: "CountryPickerView.bundle/Images/MY")
    }
}
