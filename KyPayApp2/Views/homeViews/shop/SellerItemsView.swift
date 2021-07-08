//
//  SellerItemsView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import SwiftUI
import Kingfisher

struct SellerItemsView : View {
    
    @Binding var control : PresenterControl
    
    @EnvironmentObject private var itemsViewModel : SellerItemsViewModel

    @EnvironmentObject private var userViewModel : UserViewModel
   
    @EnvironmentObject private var cartViewModel : CartViewModel
    
    
    var body: some View {
        
        view()
        
    }
    
    
    private func view() -> some View {
        
        
        ScrollView(.vertical, showsIndicators: false){
            
            VStack(alignment: .leading, spacing: 3){
            
                
                shopTitleView()
                
                itemListView()
             
            }
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 10)
        .onAppear{
            
            itemsViewModel.fetchSellerItems(currency: userViewModel.allowedCurrency)
        }
    }
}


extension SellerItemsView {
    
    private func shopTitleView() -> some View {
        
        HStack(spacing: 10) {
       
            Text("KyShop - shop here for great items").font(.custom(Theme.fontNameBold, size: 15))
            
            Common.cartBadge(cartViewPresented: $control.cartViewPresented, total: cartViewModel.total(),
                             maxSize: CGSize(width: 70, height:34), imageSize: CGSize(width: 18, height: 14),
                             fontName: Theme.fontName)
            Spacer()//.frame(width:2)
        }
        .padding(.leading, 10).padding(.top, 4).padding(.bottom, 4)
        .frame(width: UIScreen.main.bounds.width - 10)
        .background(Color(UIColor(hex: "#ddddddff")!))
     
    }
    
    
    @ViewBuilder
    private func itemListView() -> some View {
        
        if itemsViewModel.categoryIDs.count > 0 {
        
            
            ForEach(itemsViewModel.categoryIDs, id:\.self){
                cat in
                
                Text(cat).font(.custom(Theme.fontNameBold, size: 18))
                .padding(.leading, 15).padding(.top, 4).padding(.bottom, 4)
                .frame(width: UIScreen.main.bounds.width - 10, alignment: .leading)
                .background(Color(UIColor(hex:"#ccddccff")!))
                    
                if let items = itemsViewModel.byCategories[cat] {
                    
                    itemsView(items)
                }
            }
        }
        else {
            
            
            if itemsViewModel.inProgress {
          
                Text("Loading items...").padding()
                .font(.custom(Theme.fontName, size: 16))
          
            }
            
            else {
      
                VStack {
           
                    Text("Items are not available in your country or currency yet")
                    .font(.custom(Theme.fontName, size: 16))
            
                }
                .padding()
                .frame(minWidth: UIScreen.main.bounds.width - 10, minHeight:240)
                .border(Color.purple, width: 1, cornerRadius: 6)
            
            }
           
            
        }
        
    }
    
    
    private func itemsView (_ items : [SellerItem]) -> some View {
        
        ScrollView(.horizontal, showsIndicators: false){
        
            HStack (spacing:3) {
            
                ForEach(items, id:\.id) { item in
                    
                    itemView(item)
                }
            }
            
        }
        
    }
    
    
    @ViewBuilder
    private func itemView(_ item : SellerItem ) -> some View {
        
        //let _ = print("sellet.wallet::\(item.seller?.walletRefId ?? "")::\(item.seller?.serviceWalletId ?? "")::\(item.seller?.phoneNumber ?? "")::\(item.seller?.serviceCustId ?? "")")
        
        Button(action : {
            
            
            withAnimation{
                
                itemsViewModel.selectedItem = item
                
                control.itemDetailsPresented.toggle()
            }
            
        }){
        
            
            VStack(spacing:3) {
                
                Text(item.name ?? "").font(.custom(Theme.fontName, size: 16)).foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true).lineLimit(3).frame(width:100)
                
                KFImage( URL(string: item.images?.first?.url ?? ""))
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(placeHolderImageView)
                .cacheOriginalImage()
                .cacheMemoryOnly(false)
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
            
                
                //let _ = print("item.images?.first?.url ::\(item.images?.first?.url ?? "")")
            }.padding(6)
            .frame(width:140,height:200)
        }
        
    }
    
    
    private func placeHolderImageView() -> some View {
        
        Image("logo").resizable().frame(width:80).aspectRatio(contentMode: .fit)
    }
}

