//
//  CheckoutView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 05/07/2021.
//

import SwiftUI

struct CheckoutView : View {

    enum PayOption : Int {
        
        case onlineBanking
        
        case wallet
        
        case card
        
        case none
    }
    
    
    @Binding var control : PresenterControl

    @EnvironmentObject private var cartViewModel : CartViewModel

    @EnvironmentObject private var walletViewModel : UserWalletViewModel
  
    @EnvironmentObject private var userViewModel : UserViewModel
  
    @State private var isOnlineBankingPresented : Bool = false
    
    @State private var isCardPaymentPresented : Bool = false
    
    @State private var isOtherPaymentOptionsPresented : Bool = false
    
    @State private var paymentMethod : PaymentMethod?
    
    @State private var payOption : PayOption = .none
    
    @State private var confirmViewPresented : Bool = false
    
    
    var body : some View {
        
        view()
        .popOver(isPresented: $isOnlineBankingPresented, content: {
            payMethodSelectionView()
        })
        .popOver(isPresented: $isOtherPaymentOptionsPresented, content: {
            paymentOptionsView()
        })
        .popOver(isPresented: $confirmViewPresented, content: {
        
            confirmPaymentView()
        })
    }


    private func view() -> some View {
        
        VStack{

            Text("Check Out".localized).font(.custom(Theme.fontNameBold, size: 20))
            
            List{
                
                ForEach(cartViewModel.itemSellers, id:\.id){
                    
                    seller in
                    
                    let sectionText = Text(seller.name ?? "").fixedSize(horizontal: false, vertical: true).lineLimit(1).font(.custom(Theme.fontNameBold, size: 15))
                    
                    Section(header: sectionText ) {
                    
                   
                        if let items = cartViewModel.itemsBySeller[seller] {
                            
                            itemRows(items)
                            
                            subTotalView(seller: seller)
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
    private func subTotalView ( seller : Seller) -> some View  {
        
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
                
                
                TappableText(text: "Pay By Wallet".localized, action: {
                    
                })
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
       
        TappableText(text: "Pay By Other Options".localized,
        backgroundColor: Color(UIColor(hex:"#778822ff")!),action: {
                        
            self.isOtherPaymentOptionsPresented = true
                 
        })
        
    }
    
    
    @ViewBuilder
    private func infoView() -> some View {
        
        if cartViewModel.itemSellers.count > 1 {
            
            HStack {
                
                Image(systemName: "info.circle").resizable().foregroundColor(.blue).frame(width:24, height:24)
                
                 Text("Our system will automatically split the payment for the \(cartViewModel.itemSellers.count) sellers").font(.custom(Theme.fontName, size: 15)).padding(6)
                 .fixedSize(horizontal: false, vertical: true).lineLimit(200)
               
            }
            .padding(10)
            .border(Color.purple, width: 1, cornerRadius: 6)
           
        }
        
    }
    
}

extension CheckoutView {
    
    
    private func payMethodSelectionView() -> some View {
        
        PaymentMethodTypesView(control: $control, otherAction: { pm in
        
            self.paymentMethod = pm
            self.payOption = .onlineBanking
            
            withAnimation{
            
                self.isOnlineBankingPresented = false
                
                withAnimation(Animation.easeIn(duration: 0.5).delay(0.5) ){
                
                    self.confirmViewPresented = true
                    
                }
                
            }
            
        })
    }
    
    
    private func paymentOptionsView() -> some View {
        
        VStack {
            
            Text("Payment Options".localized).font(.custom(Theme.fontNameBold, size: 18))
            
            Button(action : {
                
                
                 withAnimation{
                     
                     self.isOtherPaymentOptionsPresented = false
                     self.isOnlineBankingPresented = true
                     self.isCardPaymentPresented = false
        
                 }
            }){
                
                HStack(spacing:20)  {
                    
                    Image(systemName: "house.circle")
                    .resizable()
                    .frame(width:30, height: 30)
                    .foregroundColor(.orange)
                
                    Text("Online Banking".localized)
                    .font(.custom(Theme.fontName, size: 16))
                    
                    Spacer()
                      
                }.padding()
              
            }
            
            
            Button(action : {
               
                withAnimation{
                    
                    self.isOtherPaymentOptionsPresented = false
                    self.isOnlineBankingPresented = false
                    self.isCardPaymentPresented = true
                }
            }){
                
                HStack(spacing:20) {
                    
                    Image(systemName: "creditcard.circle")
                    .resizable()
                    .frame(width:30, height: 30)
                    .foregroundColor(.green)
                
                    Text("Cards".localized)
                    .font(.custom(Theme.fontName, size: 16))
                    
                    Spacer()
                }.padding()
            }
        }
    }
}


extension CheckoutView {
    
    
    @ViewBuilder
    private func confirmPaymentView() -> some View {
        
        VStack {
            
            var currency = ""
            let total = cartViewModel.totalAmount(currency: &currency)
            
            Text("Confirm Your Payment?".localized).font(.custom(Theme.fontNameBold, size: 24))
            
            Text("\("Amount".localized): \(currency) \(total.twoDecimalString)").font(.custom(Theme.fontNameBold, size: 24))
            
            Spacer().frame(height:50)
            
            Text("Selected Payment Option:".localized).font(.custom(Theme.fontNameBold, size: 18))
            
            selectedOptionView()
            
            Spacer().frame(height:50)
            
            TappableText(text: "Proceed".localized, action: {
                
                
            })
        }
        .padding()
        .frame(minHeight:400)
    }
    
    
    @ViewBuilder
    private func selectedOptionView() -> some View {
        
        
        switch(payOption){
        
            case .onlineBanking :
            
                Common.selectedPaymentMethodView(name: paymentMethod?.name,
                    imageURL: paymentMethod?.imageURL)
            
            case .card :
                Text("Pay By Card".localized).font(.custom(Theme.fontName, size: 15))
            
            case .wallet :
                VStack {
               
                    Text("Pay By Wallet".localized).font(.custom(Theme.fontName, size: 15))
                    Text("Balance : \(walletViewModel.currency) \(walletViewModel.balance)")
                    .font(.custom(Theme.fontNameBold, size: 15)).padding()
                    .background(Color(UIColor(hex: "#ddddddff")!)).cornerRadius(10)
                    
                }
               
                
                
            default :
                
                Text("None".localized).font(.custom(Theme.fontName, size: 15))
                
                
        }
        
    }
    
}
