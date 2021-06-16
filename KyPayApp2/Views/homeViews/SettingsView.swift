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
        HStack (spacing : 15) {
            Image(systemName: systemImageName)
            .foregroundColor(imageForegroundColor)
            
            Text (title)
        }
    }
}


struct SettingsView : View {
    
    @EnvironmentObject private var viewModel : UserViewModel
    
    @State private var progressViewPresented : Bool = false
    
    @State private var errorAlertPresented : Bool = false
    
    @State private var errorMessage : String = ""
    
    @State private var promptSignOutPresented = false
    
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
                    NavigationLink(destination: EmptyView(), label: {
                        SettingRowView(title: "Edit Profile", systemImageName: "person")
                    })
                    
                    NavigationLink(destination: EmptyView(), label: {
                        SettingRowView(title: "Merchant Profile", systemImageName: "cart", imageForegroundColor: .green)
                    })
                    
                }
            
                Section(header: Text("Settings")) {
            
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
           }
        
        }
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
                Spacer()
            }.padding()
        }
        
    }
    
    
    private func signOutNow() {
        
        self.progressViewPresented = true
        
        viewModel.signOut(completion: {
            err in
            
            if let err = err {
                
                self.errorMessage = err.localizedDescription
                self.errorAlertPresented = true
            }
            
            withAnimation {
           
                self.progressViewPresented = false
               
            }
            
        })
    }
    
}
