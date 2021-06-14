//
//  CountryCodePickerUI.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import SwiftUI

struct CountryCodePickerUI : View {
    
    @EnvironmentObject private var viewModel : LoginDataViewModel
    
    let countries = Bundle.main.decodeJson([Country].self, fileName: "CountryPickerView.bundle/Data/CountryCodes.json")
    
    var body: some View {
        
        List{
            
            ForEach(countries, id:\.code){
                
                country in
                
                countryRowButton(country)
                
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
            .font(.body)
            
            Text(country.name ?? "")
            .font(.body)
            
        }
    }
}
