//
//  HomeView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI

struct HomeView : View {

    @EnvironmentObject private var viewModel : UserViewModel
    
    var body : some View {
        
        VStack {
            
            Text("Welcome Back")
            .font(.subheadline)
            
            Text("\(viewModel.firstName) \(viewModel.lastName)")
            
        }
    }
    
}
