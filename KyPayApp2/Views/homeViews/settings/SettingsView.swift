//
//  SettingsView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI
struct SettingRowView : View {
    
    var title : String
    var systemImageName : String
    var imageForegroundColor : Color = .orange
    
    
    var body : some View {
        HStack (spacing : 20) {
            Image(systemName: systemImageName)
            .resizable()
            .frame(width:20, height: 20)
            .foregroundColor(imageForegroundColor)
            
            Text (title)
            
            Spacer()
        }.padding(6)
    }
}


struct SettingsView : View {
    
    @EnvironmentObject private var userViewModel : UserViewModel
   
    @EnvironmentObject private var phoneInputViewModel : PhoneInputViewModel
    
    @State private var progressViewPresented : Bool = false
    
    @State private var errorAlertPresented : Bool = false
    
    @State private var errorMessage : String = ""
    
    @State private var promptSignOutPresented = false
    
    @State private var pushToLogin = false
    
    @State private var topUpPresented = true
    
    var body : some View {
        
        settingsView()
        .progressView(isShowing: $progressViewPresented, text: "Signing Out...")
        .alert(isPresented: $errorAlertPresented){
            Alert(title: Text("Oppps!"),message:Text(errorMessage))
        }
        .alert(isPresented: $promptSignOutPresented){
            
            Alert(title: Text("Sign Out Now?"),
                primaryButton: .default(Text("OK")) {
                    self.signOutNow()
                },secondaryButton: .cancel())
        }
       
        
    }
    
}

extension SettingsView {
    
    private func settingsView() -> some View {
        
        NavigationView {
           List {
            
                Section(header: Text("Account")) {
                    NavigationLink(destination: EditProfileView(), label: {
                        SettingRowView(title: "Edit Profile", systemImageName: "person")
                    })
                    
                    NavigationLink(destination: EmptyView(), label: {
                        SettingRowView(title:
                        userViewModel.isBusinessUser ?  "Merchant Profile".localized : "Become A Merchant".localized,
                        systemImageName: "cart", imageForegroundColor: .green)
                    })
                    
                }
            
                Section(header: Text("Settings")) {
            
                    NavigationLink(destination: TopUpView(isPresented: $topUpPresented), label: {
                        SettingRowView(title: "Your Wallet", systemImageName: "dollarsign.circle", imageForegroundColor: .purple)
                    })
                 
                    
                    NavigationLink(destination: EmptyView(), label: {
                        SettingRowView(title: "Face ID", systemImageName: "faceid", imageForegroundColor: .blue)
                    })
                    
                }
            
                Section(header: Text("Help & Info")) {
            
                    NavigationLink(destination: EmptyView(), label: {
                        SettingRowView(title: "Help Centre", systemImageName: "questionmark.circle", imageForegroundColor: .red)
                    })
                    
                }
            
                Spacer()
                
                signOutButton()
            
                loginScreenNavLink()
           }
            
           Spacer()
        
        }
    }
}

extension SettingsView {
    
    
    private func loginScreenNavLink() -> some View {
        
        NavigationLink(destination: LoginView(), isActive : $pushToLogin){}.hidden(true)
    }
}


extension SettingsView {
    
    
    private func signOutButton() -> some View {
        
        Button(action: {
            
            self.promptSignOutPresented = true 
            
        }){
            
            HStack {
                
                Spacer()
                Text("Sign Out")
                .font(.subheadline)
                .foregroundColor(Color(UIColor(hex:"#aa5500ff")!))
                
                Spacer()
            }.padding()
        }
        
    }
    
    
    private func signOutNow() {
        
        withAnimation{
       
            self.progressViewPresented = true
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5 , execute:{
       
            userViewModel.signOut(completion: {
                err in
                
                if let err = err {
                    
                    self.errorMessage = err.localizedDescription
                    self.errorAlertPresented = true
                }
                
                withAnimation {
               
                    self.progressViewPresented = false
                    
                    self.pushToLogin = true
                    
                }
                
            })
        })
       
    }
    
}
