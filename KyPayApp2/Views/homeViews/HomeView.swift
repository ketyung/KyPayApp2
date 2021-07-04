//
//  HomeView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 15/06/2021.
//

import SwiftUI


struct HomeView : View {

    @EnvironmentObject private var viewModel : UserViewModel
    
    @EnvironmentObject private var txInputViewModel : TxInputDataViewModel
  
    
    @State private var control = PresenterControl()
    
    var body : some View {
        
        view()
        .onDisappear{ control.reset()}
        .environmentObject(TopUpPaymentViewModel())
        .environmentObject(PaymentMethodsViewModel())
        
    }
    
}


extension HomeView {
    
    private func view () -> some View {
        
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            
            VStack(spacing:20) {
    
                Spacer().frame(height: 50)
                
                welcomePanel()
                
                buttonsScrollView()
                
                billerButtonView()
                
                SellerItemsView()
                
                Spacer()
        
            }
        }
        .padding()
        .frame(width:UIScreen.main.bounds.width )
        .bottomSheet(isPresented: $control.topUpPresented, height: UIScreen.main.bounds.height, showGrayOverlay: true, content:{
        
            TopUpView(control: $control)
        })
      
        .bottomSheet(isPresented: $control.paymentMethodSelectorPresented, height: UIScreen.main.bounds.height, showGrayOverlay: true, content:{
            
            PaymentMethodTypesView(control: $control)
            
        })
        .bottomSheet(isPresented: $control.cardPaymentPresented, height: UIScreen.main.bounds.height, showGrayOverlay: true, content:{
            
            CardPaymentView()
        })
       
        .bottomSheet(isPresented: $control.topUpPaymentPresented, height: UIScreen.main.bounds.height, showGrayOverlay: true, content:{
                  
            TopUpPaymentView(control: $control)
        })
            
        .bottomSheet(isPresented: $control.sendMoneyPresented, height: UIScreen.main.bounds.height, showGrayOverlay: true, content:{
            
            SendView()
        })
        .bottomSheet(isPresented: $control.billerPaymentPresented, height: UIScreen.main.bounds.height, showGrayOverlay: true, content:{
      
            BillersSelectionView()
        })
      
        
    }
}


extension HomeView {
    
    
    private func welcomePanel() -> some View {
        
        VStack {
       
            Text("Welcome Back")
            .font(.subheadline)
            
            Text("\(viewModel.firstName) \(viewModel.lastName)")
            .font(.headline)
           
        }
        .padding(6)
        .frame(width: UIScreen.main.bounds.width - 40)
        .background(
            LinearGradient(gradient: Gradient(colors: [ Color(UIColor(hex:"#ccccccff")!), Color(UIColor(hex:"#ddeeffff")!)]),
            startPoint: .leading, endPoint: .trailing)
        )
        
        .cornerRadius(10)
    }
}


extension HomeView {
    
    private func buttonsScrollView() -> some View {
        
        VStack {
       
            Text("What can you do with KyPay app?")
            .font(.custom(Theme.fontName, size: 20))
            .frame(alignment: .leading)
            
            
            ScrollView(.horizontal, showsIndicators: false ){
                
                HStack(spacing:4) {
                    
                    Button(action: {
                        
                        control.topUpPresented.toggle()
                        
                    }){
                        
                        HomeView.buttonView(color : Color(UIColor(hex:"#5566aaff")!), imageOne: "wallet",
                                   imageTwo: "plus.circle", text: "Top Up")
                    }
                    
                    Button(action: {
                        
                        txInputViewModel.reset()
                        control.sendMoneyPresented.toggle()
                        
                    }){
                        
                        HomeView.buttonView(color: Color(UIColor(hex:"#F2a642ff")!), imageOne: "dollarsign.circle.fill",
                                   imageOneForegroundColor: Color(UIColor(hex:"#aa0000ff")!),
                                   imageTwo: "arrow.right", text: "Send Money")
                    }
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
                        
                        HomeView.buttonView(color: .purple, imageOne: "arrow.left", imageOneSize:  CGSize(width:18, height:18),
                        imageOneForegroundColor: Color(UIColor(hex:"#DDFFDDFF")!),
                        imageTwo: "dollarsign.circle.fill", imageTwoSize:  CGSize(width:32, height:32),
                        imageTwoForegroundColor: Color(UIColor(hex:"#55dd66ff")!) ,
                        text: "Request Money")
                    }
                    
                }.padding(4)
            }
        }
       
    }
    
    
    private func billerButtonView() -> some View {
        
        
        Button(action: {
            
            withAnimation{
                
                control.billerPaymentPresented = true 
            }
            
        }){
            
            HomeView.buttonView(equallyDivideBy : 1, screenWidthSubstract: 40,
                                color: Color(UIColor(hex:"#666680ff")!), imageOne: "biller",
                       imageOneForegroundColor: Color(UIColor(hex:"#aa0000ff")!),
                       imageTwo: "arrow.up", text: "Pay Bills")
        }
        
    }
    
    
}

extension HomeView {
    
    
    
    static func buttonView (  equallyDivideBy : CGFloat = 3, screenWidthSubstract : CGFloat = 75,
                              color : Color = .green, imageOne : String,
                              imageOneSize : CGSize = CGSize(width:32, height: 32),
                              imageOneForegroundColor : Color = .brown,
                              imageTwo : String,
                              imageTwoSize : CGSize = CGSize(width:18, height: 18),
                              imageTwoForegroundColor : Color = .white,
                              text : String ) -> some View{
        
        
        ZStack {
            
            let w = (UIScreen.main.bounds.width - screenWidthSubstract) / equallyDivideBy
            
            //let _ = print("w:::::\(w)")
            
            Rectangle()
            .fill(color)
            .frame(width: w, height: 70)
            .cornerRadius(10)
            .padding(6)
                
            VStack {
            
                HStack {
                
                    if let img = UIImage(named: imageOne){
                        
                        Image(uiImage: img)
                        .resizable()
                        .frame(width:imageOneSize.width, height: imageOneSize.height)
                        .foregroundColor(imageOneForegroundColor)
                     
                    }
                    else {
                        
                        Image(systemName: imageOne)
                        .resizable()
                        .frame(width:imageOneSize.width, height: imageOneSize.height)
                        .foregroundColor(imageOneForegroundColor)
                        
                    }
                    
                    if let img2 = UIImage(named: imageTwo){
                        
                        Image(uiImage: img2)
                        .resizable()
                        .frame(width:imageTwoSize.width, height: imageTwoSize.height)
                        .foregroundColor(imageTwoForegroundColor)
                        
                    }
                    else {
                        
                        Image(systemName: imageTwo)
                        .resizable()
                        .frame(width:imageTwoSize.width, height: imageTwoSize.height)
                        .foregroundColor(imageTwoForegroundColor)
                       
                    }
                
                }
                
                Text(text)
                .font(.custom(Theme.fontName, size: 12))
                .foregroundColor(.white)
                
            }
            
            
        }
        
    }
    
    
    
}
