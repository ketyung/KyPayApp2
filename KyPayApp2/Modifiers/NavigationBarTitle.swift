//
//  NavigationBarTitle.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 20/06/2021.
//

import SwiftUI

struct NavigationBarTitle : ViewModifier {
 
    let title : Text
    
    let displayMode: NavigationBarItem.TitleDisplayMode
    
    func body(content : Content) -> some View{
    
        if #available(iOS 14, *) {
    
            content.navigationTitle(title).navigationBarTitleDisplayMode(displayMode)
        }
        else {
            
            content.navigationBarTitle(title, displayMode: displayMode)
        }
    }
}

extension View {
    
    func navigationBar(title : Text, displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        
        return self.modifier(NavigationBarTitle(title: title, displayMode: displayMode))
    }
}
