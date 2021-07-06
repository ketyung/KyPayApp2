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
    
    @State private var showShareSheet : Bool = false
    
    @State private var snapshotImages :[Any] = []
    
    @State private var paymentSuccess : Bool = false

    @State private var orderNumber : String?
    
    
    var body : some View {
        
        view()
        .popOver(isPresented: $isOnlineBankingPresented, content: {
            payMethodSelectionView()
        })
        .popOver(isPresented: $isOtherPaymentOptionsPresented, content: {
            paymentOptionsView()
        })
        .popOver(isPresented: $cartViewModel.confirmViewPresented, content: {
        
            confirmPaymentView()
        })
            .progressView(isShowing: $cartViewModel.inProgress, text: "Processing...".localized)
        .popOver(isPresented: $cartViewModel.errorPresented, content: {
        
            Common.errorAlertView(message: cartViewModel.errorMessage ?? "Error!")
            
        })
        .sheet(isPresented: $showShareSheet, content: {
        
            ShareView(activityItems: $snapshotImages)
               
        })
    }


    private func view() -> some View {
        
        VStack{
            
            if paymentSuccess {
                
                paymentSuccessInfoView()
            }
            else {
            
                Text("Check Out".localized).font(.custom(Theme.fontNameBold, size: 20))
           
                orderListView()
            }
            
        }
    }
}

extension CheckoutView {
    
    
    private func orderListView() -> some View {
        
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
    
    
    
    
    private func paymentSuccessInfoView(withLogo : Bool = false ) -> some View {
        
        VStack(spacing:20) {
      
            HStack {
                
                Image(systemName: "checkmark.circle").resizable().frame(width: 30, height: 30)
                .aspectRatio(contentMode: .fit).foregroundColor(Color(UIColor(hex:"#aaff22ff")!))
               
                Text("Payment Success".localized).font(.custom(Theme.fontNameBold, size: 20)).foregroundColor(.white)
                
                Button(action: {
                    
                    self.shareSnapShot()
                    
                }){
                
                    Image("more").resizable().frame(width:24, height: 24, alignment: .topTrailing).foregroundColor(.white)
                }
                
            }
            .padding().frame(minWidth: UIScreen.main.bounds.width - 20 ).background(Color(UIColor(hex:"#556688ff")!))
            .cornerRadius(10)
        
            
            Text("Thank You".localized).font(.custom(Theme.fontNameBold, size: 28)).foregroundColor(.black)
          
            if let orderNum = self.orderNumber {
          
                Text("Your Order no is:".localized).font(.custom(Theme.fontName, size: 18)).foregroundColor(.black)
                Text(orderNum).font(.custom(Theme.fontNameBold, size: 20)).foregroundColor(.black)
                
                Common.qrCodeImageView(from: orderNum)
                
                Text("You can also view your order status in your order list later")
                .font(.custom(Theme.fontName, size: 18)).foregroundColor(.gray)
            }
            
            Spacer()
            
            if withLogo {
                
                Common.logo()
            }
          
        
        }.padding()
      
    }
    
    
    private func shareSnapShot(){
        
        let image = paymentSuccessInfoView(withLogo: true).snapshot()
        self.snapshotImages = [image]
        withAnimation {

            self.showShareSheet.toggle()
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
        
        if cartViewModel.totalAmount() > 0 {
       
            
            if walletViewModel.balanceValue > cartViewModel.totalAmount(){
     
                VStack(alignment: .leading, spacing:20) {
                 
                    Text("Payment Options :".localized).font(.custom(Theme.fontNameBold, size: 16))
                    
                    
                    TappableText(text: "Pay By Wallet".localized, action: {
                        
                        withAnimation{
                            
                            self.payOption = .wallet
                            cartViewModel.confirmViewPresented = true
                        }
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
                
                    cartViewModel.confirmViewPresented = true
                    
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
                
                proceedBasedOnOption()
                
            })
        }
        .padding()
        .frame(minHeight:400)
    }
    
    
    private func proceedBasedOnOption(){
        
        if payOption == .wallet {
            
            cartViewModel.payByWallet(by: userViewModel.user, with: walletViewModel.refId, completion: {
                
                orderNumber in
                
                if let orderNumber = orderNumber {
                    
                    self.orderNumber = orderNumber
                    
                    withAnimation{
                        
                        self.paymentSuccess.toggle()
                    }
                }
                
            })
        }
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
