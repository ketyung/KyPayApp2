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
    
    @State private var amountText : String = "" {
        
        didSet{
            
            amountText = String(format: "%.2f", amountText)
            
            print("am.txt::\(amountText)")
        }
    }
    
    var body: some View {
        
        VStack{
            
            Spacer().frame(height:10)
            
            billerLogo()
            
            accountNumberView()
            
            Spacer().frame(height:20)
            
            amountView()
            
            Spacer()
        }
        .bottomFloatingButton( isPresented: true, action: {
    
        })
        .backButton()
        .navigationBar(title: Text(biller.name ?? ""), displayMode: .inline)
    }

}

extension BillerNumberView {
    
    private func accountNumberView() -> some View {
        
        VStack(alignment: .leading, spacing: 2){
       
            let n = billerNumberTitle()
            Text(n).font(.custom(Theme.fontName, size: 16))
            
            TextField(n, text: $enteredNumber)
            .keyboardType(.numberPad)
            .frame(width: 200, height: 24)
            .overlay(VStack{Divider().backgroundFill(.black).offset(x: 0, y: 20)})
        }
     
    }
    
    @ViewBuilder
    private func amountView() -> some View {
        
        let currency = CurrencyManager.currency(countryCode: biller.country ?? "MY") ?? "MYR"
        let amountTitle = "\("Amount".localized) (\(currency))"
        
        VStack(alignment: .leading, spacing: 2){
       
            Text(amountTitle).font(.custom(Theme.fontNameBold, size: 16)).foregroundColor(Color(UIColor(hex:"#888888ff")!))
            
            TextField("Amount", text: $amountText)
            .keyboardType(.decimalPad)
            .frame(width: 200, height: 24).font(.custom(Theme.fontName, size: 30))
            .overlay(VStack{Divider().backgroundFill(.black).offset(x: 0, y: 20)})
        }
     
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
           
            Circle().fill(Color(UIColor(hex:"#aabbccff")!)).frame(width: 120, height: 120).padding()
           
            
            Circle().fill(Color(UIColor(hex:"#eeeeffff")!)).frame(width: 100, height: 100).padding()
            
            
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
