//
//  CountryCodePickerUI.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI

struct CountryCodePickerUI : View {
    
    //@EnvironmentObject private
    
    @Environment(\.colorScheme) var colorScheme
    
    var viewModel : PhoneInputViewModel

    var textFont : Font
   
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
        .onAppear{
            
            viewModel.phoneNumberIsFirstResponder = false
        }
    }
}


extension CountryCodePickerUI {
    
    private func defaultTextColor() -> Color {
        
        let c = ((colorScheme == .dark) ? Color.white : Color.black)
        return c
    }
    
    
    private func defaultTextFont() -> Font {
        
        return .custom(Theme.fontName, size: 15)
    }
    
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
            
            Text(country.code ??  "MY")
            .font(textFont)
            .foregroundColor(defaultTextColor())
            
            Text(country.name ?? "")
            .font(.body)
            .foregroundColor(defaultTextColor())
                
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundColor(Color(UIColor(hex:"#338855ff")!))
            .frame(width:20,height:20)
            .hidden(viewModel.selectedCountry?.code ?? "MY" != country.code)
            
        }.padding()
    }
}
