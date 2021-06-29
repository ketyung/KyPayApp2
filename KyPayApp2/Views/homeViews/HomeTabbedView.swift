//
//  HomeTabbedView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct HomeTabbedView : View {
    
    @State private var selectedTab : Int = 0
      
    @EnvironmentObject private var phoneInputViewModel : PhoneInputViewModel
   
    @EnvironmentObject private var userViewModel : UserViewModel
    
    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    @EnvironmentObject private var txInputViewModel : TxInputDataViewModel
   
    var handler: Binding<Int> { Binding(
       get: { self.selectedTab },
       set: {
            if $0 == 0 || $0 == 1{
            
                txInputViewModel.reset()
            }
            self.selectedTab = $0
       }
   )}
   
    var body: some View {
    
        tabbedView()
        .bottomSheet(isPresented: $userViewModel.firstSignIn, height: UIScreen.main.bounds.height + 80, showGrayOverlay: false){
        
            FirstSignInView()
        }
        .onAppear {
            
            self.fetchWalletIfNotPresent()
        }
        
    }
}


extension HomeTabbedView {
    
    private func tabbedView() -> some View {
        
        TabView(selection: handler ){
           
            HomeView()
           .tabItem {tabLabel("Home", systemImage: "house")}
           .tag(0)
           
        
           SendView()
           .tabItem {tabLabel("Send Money", systemImage: "arrow.right.circle")}
           .tag(1)
           
            
           RequestView()
           .tabItem {tabLabel("Request Money", systemImage: "arrow.left.circle")}
           .tag(2)
            
            
           SettingsView()
           .tabItem {tabLabel("Settings", systemImage: "gear")}
           .tag(3)
       }
       .onAppear{
           // always reset back to zero
           self.selectedTab = 0
           phoneInputViewModel.removeAllUnneeded()
       }
       .navigationBarBackButtonHidden(true)
       .navigationBarHidden(true)
     
    }
}


extension HomeTabbedView {
    
    @ViewBuilder
    func tabLabel(_ text : String , systemImage : String ) -> some View {
        
        if #available(iOS 14.0, *) {
            Label(text, systemImage: systemImage)
        } else {
            
            VStack {
    
                Text(text)
                Image(systemName: systemImage)
            }
        }
    }
}

extension HomeTabbedView {
    
    private func fetchWalletIfNotPresent(){
        
        walletViewModel.fetchWalletIfNotPresent(user: userViewModel.user, completion: {
            
            err in
            
            guard let _ = err else {
                
                return
            }
    
        })
        
    }
   
}
