//
//  HomeTabbedView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct HomeTabbedView : View {
    
    @State private var selectedTab : Int = 0
      
    var body: some View {
    
        TabView(selection: $selectedTab ){
           
            HomeView()
           .tabItem {Label("Home", systemImage: "house")}
           .tag(0)
           
        
           SendView()
           .tabItem {Label("Send Money", systemImage: "arrow.right.circle")}
           .tag(1)
           
            
           RequestView()
           .tabItem {Label("Request Money", systemImage: "arrow.left.circle")}
           .tag(2)
            
            
           SettingsView()
           .tabItem {Label("Settings", systemImage: "gear")}
           .tag(3)
       }
       .onAppear{
           // always reset back to zero
           self.selectedTab = 0
       }
    }
}
