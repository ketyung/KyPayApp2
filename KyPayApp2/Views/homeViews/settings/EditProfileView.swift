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
    
    @ObservedObject private var countryPickerViewModel = PhoneInputViewModel()
    
    @State private var errorPresented : Bool = false
    
    var body: some View {
        
        profileFormView()
        .popOver(isPresented: $countryPickerViewModel.isCountryPickerPresented){
        
            CountryCodePickerUI(viewModel: countryPickerViewModel, textFont: .custom(Theme.fontName, size: 15))
        }
        .onAppear{
                
            userViewModel.loadUser(viewModel.user)
        }
        .backButton()
        
          
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
        
        VStack(spacing:5) {
       
            Spacer()
            .frame(height: 20)
            
            infoTitleView()
            
            profileImageView()
            
            
            Form{
                
                TextField("First Name", text: $userViewModel.firstName )
                //.isFirstResponder(true)
                
                TextField("Last Name", text: $userViewModel.lastName )
                
                phoneView()
                
                TextField("Email", text: $userViewModel.email )
                
                DatePicker("Date Of Birth", selection: $userViewModel.dob, displayedComponents: .date)
            }
            .frame(minHeight: 300)
            
            Button(action: {
                
                UIApplication.shared.endEditing()
                errorPresented = true
                
            }){
                
                Text("Update").padding()
                
            }
           
            Spacer()
            .frame(minHeight: 200)
        }
        .popOver(isPresented: $errorPresented , content: {
            
            Common.errorAlertView(message: "Opps : Feature isn't available! Coming soon...".localized)
        })
        
    }
    
    
    private func profileImageView() -> some View {
        
        Button(action:{}){
            ZStack {
                
                Color.gray.frame(width:80, height: 80).cornerRadius(50)
                
                Image(systemName: "person").resizable().frame(width:30,height:30).aspectRatio(contentMode: .fit).foregroundColor(.white)
            }
        }
       
    }
}


extension EditProfileView {
    
    private func phoneView() -> some View {
        
        HStack(spacing:2) {
            
            flagButton()
            phoneTextField()
            
        }
    }
    
    private func phoneTextField() -> some View {
    
        
        CocoaTextField("Phone Number", text: $userViewModel.phoneNumberOnly)
        .font(UIFont.boldSystemFont(ofSize: 20))
        .width(200)
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
            
            withAnimation{
           
                self.countryPickerViewModel.isCountryPickerPresented = true
            }
            
        }){
            
            HStack {
       
                if let img = selectedCountryImage() {
                    
                    let w : CGFloat = 30
                    let h = img.size.height / img.size.width * w
            
                    Image(uiImage: img)
                    .resizable()
                    .frame(width: w, height: h, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                }
       
                Text(countryPickerViewModel.selectedCountry?.dialCode ?? "+60")
                .foregroundColor(.black)
                .font(Font.system(size: 18, design: .rounded))
                .lineLimit(1)
            
            }.frame(width:100)
            
        }
        
       
    }
    
    private func selectedCountryImage() -> UIImage? {
        
        if let country = countryPickerViewModel.selectedCountry {
            
            return country.flag
        }
        
        return UIImage(named: "CountryPickerView.bundle/Images/MY")
    }
}
