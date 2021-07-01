//
//  BillersSelectionView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 01/07/2021.
//

import SwiftUI
import Kingfisher

struct BillersSelectionView : View {
    
    @ObservedObject private var billersViewModel = BillersViewModel()
    
    @EnvironmentObject private var userViewModel : UserViewModel
    
    var body: some View {
        
        VStack{
            
            Text("Choose a biller").font(.custom(Theme.fontName, size: 18))
            
            List(billersViewModel.billers, id:\.id) { biller in
                
                billerRow(biller)
            }
        
        }
        .popOver(isPresented: $billersViewModel.errorPresented , content: {
            
            Common.errorAlertView(message: billersViewModel.errorMessage)
        })
        .progressView(isShowing: $billersViewModel.showProgressIndicator)
        .onAppear{
            billersViewModel.fetchBillers(country: userViewModel.countryCode)
        }
    }
}


extension BillersSelectionView {
    
    
    private func billerRow( _ biller : Biller ) -> some View{
        
        Button (action: {}){
        
            HStack {
                
                KFImage( URL(string: biller.iconUrl ?? ""))
                .resizable()
                .loadDiskFileSynchronously()
                .placeholder(Common.imagePlaceHolderView)
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
            
                Text(biller.name ?? "")
                .font(.custom(Theme.fontName, size: 15))
                .frame(minWidth: 160, alignment: .leading)
                .padding()
                
                Spacer()
                
                // let _ = print("biller.bid::\(biller.name ?? ""):::\(biller.serviceBid ?? "xxx")")
                
                Common.disclosureIndicator()
              
            }
        }
        
    }
}
