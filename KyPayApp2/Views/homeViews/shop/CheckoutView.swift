//
//  CheckoutView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 05/07/2021.
//

import SwiftUI

struct CheckoutView : View {
    
    @EnvironmentObject private var cartViewModel : CartViewModel

    @EnvironmentObject private var walletViewModel : UserWalletViewModel
    
    
    var body : some View {
        
        VStack{
   
            Text("Check Out".localized).font(.custom(Theme.fontNameBold, size: 20))
            
            List{
                
                ForEach(cartViewModel.itemSellers, id:\.self){
                    
                    sellerId in
                    
                    let sectionText = Text(sellerId).fixedSize(horizontal: false, vertical: true).lineLimit(1).font(.custom(Theme.fontNameBold, size: 15))
                    
                    Section(header: sectionText ) {
                    
                   
                        if let items = cartViewModel.itemsBySellerName[sellerId] {
                            
                            itemRows(items)
                            
                            subTotalView(seller: sellerId)
                        }
                    }
                }
                
                totalView()
                
                payButtons()
                
                infoView()
            }
            
           
        }
    }
}

extension CheckoutView {
    
    

    private func itemRows ( _ items : [CartItem]) -> some View {
        
    
        ForEach(items, id:\.item.id) {
            
            item in
        
            itemRow(item)
            
        }
    
    }
    
    
    private func itemRow (_ item : CartItem) -> some View {
        
        NavigationLink (destination: EmptyView()){
            
            HStack {
          
                Text(item.item.name ?? "").font(.custom(Theme.fontNameBold, size: 15))
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true).lineLimit(3).frame(maxWidth:160)
              
                Text("\(item.item.currency ?? "") \(item.item.price?.twoDecimalString ?? "") x \(item.quantity) = \(item.subTotal.twoDecimalString)")
                .font(.custom(Theme.fontName, size: 16))
            
                Spacer()
            
            }
            
        }
        
    }
    
}

extension CheckoutView {
    
    
    @ViewBuilder
    private func subTotalView ( seller : String) -> some View  {
        
        var currency = Common.defaultCurrency
        let subTotal = cartViewModel.subTotalAmountBy(seller: seller, currency: &currency)
        
        HStack {
            
            Spacer()
            
            Text("\("Sub-total".localized) : \(currency) \(subTotal.twoDecimalString)")
            .font(.custom(Theme.fontNameBold, size: 15))
            
        }
    }
    
    @ViewBuilder
    private func totalView() -> some View {
        
        var currency = Common.defaultCurrency
        let total = cartViewModel.totalAmount(currency: &currency)
        
        HStack {
            
            Spacer()
      
            Text("\("Total".localized) : \(currency) \(total.twoDecimalString)")
            .font(.custom(Theme.fontNameBold, size: 15))
      
            
        }
    }
}


extension CheckoutView {
    
    
    @ViewBuilder
    private func payButtons() -> some View {
        
        if walletViewModel.balanceValue > cartViewModel.totalAmount(){
 
            VStack(alignment: .leading, spacing:20) {
             
                Text("Payment Options :".localized).font(.custom(Theme.fontNameBold, size: 16))
                
                
                Button(action: {}){
                    
                    Text("Pay By Wallet".localized).font(.custom(Theme.fontNameBold, size: 18)).padding().frame(width: 300, height: 40)
                        .foregroundColor(.white).background(Theme.commonBgColor)
                        .cornerRadius(6)
                }
                
                payByOthersButton()
               
            }
        }
        else {
            
            VStack {
                
                Text("Insufficient fund in wallet, you can only pay by other methods".localized).font(.custom(Theme.fontName, size: 14))
                
                payByOthersButton()
            }
        }
    }
    
    
    private func payByOthersButton() -> some View {
        
        Button(action: {}){
            
            Text("Pay By Other Methods".localized).font(.custom(Theme.fontNameBold, size: 18)).padding().frame(width: 300, height: 40)
                .foregroundColor(.white).background(Color(UIColor(hex:"#778822ff")!))
                .cornerRadius(6)
        }
    }
    
    
    @ViewBuilder
    private func infoView() -> some View {
        
        if cartViewModel.itemSellers.count > 1 {
            
            HStack {
                
                Image(systemName: "info.circle").resizable().foregroundColor(.blue).frame(width:24, height:24)
                
                 Text("Our system will automatically the payment for the \(cartViewModel.itemSellers.count) sellers").font(.custom(Theme.fontName, size: 15)).padding(6)
                 .fixedSize(horizontal: false, vertical: true).lineLimit(200)
               
            }
            .padding(10)
            .border(Color.purple, width: 1, cornerRadius: 6)
           
        }
        
    }
    
}
