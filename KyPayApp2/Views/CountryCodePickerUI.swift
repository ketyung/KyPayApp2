//
//  CountryCodePickerUI.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI
import CountryPickerView

struct CountryCodePickerUI : UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> CountryPickerView {
    
        let cpv = CountryPickerView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
        
        
        
        return cpv
    }

    func updateUIView(_ uiView: CountryPickerView, context: Context) {
        
    }
    
}
