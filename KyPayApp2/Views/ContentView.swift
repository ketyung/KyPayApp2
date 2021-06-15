//
//  ContentView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 12/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var viewModel : UserViewModel
    
    var body: some View {
        
        view()
    }
}


extension ContentView {
    
    
    @ViewBuilder
    private func view() -> some View {
        
        if viewModel.hasSignedIn() {
            
            HomeTabbedView()
        }
        else {
            
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
