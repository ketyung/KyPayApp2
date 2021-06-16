//
//  HomeTabbedView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct HomeTabbedView : View {
    
    @State private var selectedTab : Int = 0
      
    @EnvironmentObject private var loginViewModel : LoginDataViewModel
    
    var body: some View {
    
        tabbedView()
        
    }
}


extension HomeTabbedView {
    
    private func tabbedView() -> some View {
        
        TabView(selection: $selectedTab ){
           
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
           loginViewModel.removeAllUnneeded()
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