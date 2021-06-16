//
//  CountryCodePickerUI.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI

struct CountryCodePickerUI : View {
    
    //@EnvironmentObject private
    
    var viewModel : LoginDataViewModel

    var textColor : Color = .black

    var textFont : Font = .body
    

    @State private var searchText : String = ""
    
    var body: some View {
        
        
        VStack {
            
            SearchBar(text: $searchText)
            
            List{
                
                ForEach( Country.countries.filter({ searchText.isEmpty ?
                true : ($0.name?.contains(searchText) ?? true) }) , id:\.code)
                {
                    country in
                    countryRowButton(country)
                }
            }
            
        }
        
    }
}


extension CountryCodePickerUI {
    
    
    private func countryRowButton(_ country : Country ) -> some View {
        
        Button(action: {
            
            viewModel.selectedCountry = country
            
            withAnimation{
                
                viewModel.isCountryPickerPresented = false
            }
        }, label: {
        
            countryRow(country)
        })
    }
    
    
    private func countryRow(_ country : Country ) -> some View {
        
        HStack(spacing: 20) {
            
            if let img = country.flag {
                
                let w : CGFloat = 30
                let h = img.size.height / img.size.width * w
           
                Image(uiImage: img)
                .resizable()
                .frame(width: w, height: h, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
             
            }
            
            Text(country.code ?? "")
            .font(textFont)
            .foregroundColor(textColor)
            
            Text(country.name ?? "")
            .font(textFont)
            .foregroundColor(textColor)
                
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundColor(Color(UIColor(hex:"#338855ff")!))
            .frame(width:20,height:20)
            .hidden(viewModel.selectedCountry?.code ?? "MY" != country.code)
            
        }.padding()
    }
}
