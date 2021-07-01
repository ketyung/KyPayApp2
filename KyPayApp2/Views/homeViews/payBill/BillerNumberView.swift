//
//  BillerNumberView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 01/07/2021.
//

import SwiftUI
import Kingfisher

struct BillerNumberView : View {
    
    let biller : Biller
    
    @State private var enteredNumber : String = ""
    
    var body: some View {
        
        VStack{
            
            Spacer().frame(height:20)
            
            billerLogo()
            
            VStack(alignment: .leading, spacing: 2){
           
                let n = billerNumberTitle()
                Text(n).font(.custom(Theme.fontName, size: 16))
                
                TextField(n, text: $enteredNumber)
                .keyboardType(.numberPad)
                .frame(width: 260, height: 24)
                .overlay(VStack{Divider().backgroundFill(.black).offset(x: 0, y: 20)})
               
            }
            
            Spacer()
        }
        .backButton()
        .navigationBar(title: Text(biller.name ?? ""), displayMode: .inline)
    }

}

extension BillerNumberView  {
    
    private func billerNumberTitle() -> String{
        
        switch(biller.byType) {
        
            case .accountNumber :
                return "Account Number".localized
                
            case .phoneNumber :
                return "Phone Number".localized
                
            case .others :
                return "Others".localized
            
            default :
                return "none".localized
            
        }
    }
    
    
    private func billerLogo() -> some View {
        
        ZStack {
            
            Circle().fill(Color(UIColor(hex:"#ddeeffff")!)).frame(width: 100, height: 100).padding()
            
            
            KFImage( URL(string: biller.iconUrl ?? ""))
            .resizable()
            .loadDiskFileSynchronously()
            .placeholder(Common.imagePlaceHolderView)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .aspectRatio(contentMode: .fit)
            .frame(width: 60)
        
        }.onTapGesture {
            
            UIApplication.shared.endEditing()
        }
    }
    
}
