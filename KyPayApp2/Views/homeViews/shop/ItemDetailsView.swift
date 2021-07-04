//
//  ItemDetailsView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 04/07/2021.
//

import SwiftUI
import Kingfisher

struct ItemDetailsView : View {
    
    @EnvironmentObject private var itemsViewModel : SellerItemsViewModel

    var body: some View {
        
        VStack {
            
    
            ScrollView(.vertical, showsIndicators: false) {
        
                itemView(itemsViewModel.selectedItem)
                
            }
            .padding()
            .frame(maxHeight: UIScreen.main.bounds.height - 140)
            
            Spacer()//.frame(minHeight: 20)
       
        }
    }
    
}

extension ItemDetailsView {
    
    @ViewBuilder
    private func itemView( _ item : SellerItem?) -> some View {
        
        if let item = item {
       
            VStack(alignment: .leading, spacing: 8) {
           
                Text(item.name ?? "").font(.custom(Theme.fontNameBold, size: 20)).padding(.leading, 2)
                .fixedSize(horizontal: false, vertical: true).lineLimit(3)
                .frame(width: UIScreen.main.bounds.width - 60)
               
                
                KFImage( URL(string: item.images?.first?.url ?? ""))
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(Common.imagePlaceHolderView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .padding(.leading, 20)
                .aspectRatio(contentMode: .fit)
                .frame(width: 240)
                
                
                
                HStack {
                    Text("Price :").font(.custom(Theme.fontNameBold, size: 18)).padding(6)
                    Text("\(item.currency ?? Common.defaultCurrency) \(item.price?.twoDecimalString ?? "0.00")")
                }.padding().border(Color.green, width: 1, cornerRadius: 6)
                
                
                VStack(alignment: .leading, spacing: 2) {
                
                    Text("Description :".localized).font(.custom(Theme.fontNameBold, size: 18))
                    
               
                    Text(item.description ?? "").font(.custom(Theme.fontName, size: 20)).padding(6)
                    .fixedSize(horizontal: false, vertical: true).lineLimit(20)
                    .frame(minWidth: UIScreen.main.bounds.width - 60)
                   
                }
                .padding(.leading, 1).padding(.leading, 10)
                .padding(.top, 6).padding(.bottom, 10)
                .border(Color.purple, width: 1, cornerRadius: 6)
                
            
            }.padding(.leading, 10).padding(.bottom, 8).padding(.top, 8)
           
        }
        else {
            
            Text("No Item Selected!")
        }
        
        
    }
}
