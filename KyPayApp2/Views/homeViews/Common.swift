//
//  Common.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 28/06/2021.
//

import SwiftUIX
import Kingfisher
import CoreImage
import CoreImage.CIFilterBuiltins

struct Common {
    
    
    static func paymentSuccessView (amount : String, balance : String,
    currency : String, showBalance : Bool = true, withLogo : Bool = false,
    note : String? = nil, subTitle : String = "Transfer Amount :".localized) -> some View {
        
        VStack{
            
            
            Text("Success".localized).font(.custom(Theme.fontName, size: 30))
            
            Image(systemName: "checkmark.circle").resizable().frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit).foregroundColor(Color(UIColor(hex:"#aaff22ff")!))
            
            VStack {
           
                Text(subTitle)
                .font(.custom(Theme.fontName, size: 20)).foregroundColor(Color(UIColor(hex:"#aaaabbff")!))
               
                Text("\(currency) \(amount)")
                .font(.custom(Theme.fontName, size: 20)).foregroundColor(Color(UIColor(hex:"#aaaabbff")!))
                   
            }
            
            if let note = note, !note.isEmpty {
                
                VStack(spacing:2) {
                    
                    Spacer().frame(height:5)
                    
                    Text("Note :").font(.custom(Theme.fontName, size: 16))
                    
                    Text("\(note)").font(.custom(Theme.fontName, size: 16))
                    .foregroundColor(Color(UIColor(hex:"#666666ff")!))
                    
                }
                
            }
            
            if showBalance {
               
                Spacer().frame(height:30)
               
                
                VStack {
               
                    Text("Current Balance :".localized)
                    .font(.custom(Theme.fontNameBold, size: 26)).foregroundColor(Color(UIColor(hex:"#999999ff")!))
                   
                    Text("\(currency) \(balance)")
                    .font(.custom(Theme.fontNameBold, size: 30)).foregroundColor(Color(UIColor(hex:"#333333ff")!))
                       
                }
                Spacer()
               
            }
            else {
                
                Spacer().frame(height:50)
               
            }
            
            
            if withLogo {
                
                logo()
            }
            
              
        }
    }
    
    static func logo() -> some View {
        
        HStack(spacing:2) {
            
            Spacer()
        
            Image("logo").resizable().frame(width:36, height: 36).aspectRatio(contentMode: .fit)
        
            Spacer().frame(width:3)
        
        }
    }
    
    
    static func errorAlertView( message : String) -> some View {
        
         VStack {
        
             Spacer().frame(height: 30)
             
             HStack (spacing: 2) {
             
                 Image(systemName: "info.circle.fill")
                 .resizable()
                 .frame(width:24, height: 24)
                 .foregroundColor(Color(UIColor(hex:"#aa0000ff")!))
                 
                 Text(message)
                 .padding()
                 .fixedSize(horizontal: false, vertical: true)
                 .font(.custom(Theme.fontName, size: 16))
                 .lineLimit(3)
             }
             .padding(4)
             
             Spacer()
         }
         .padding()
         .frame(width: UIScreen.main.bounds.width - 40, height: 200)
         .cornerRadius(4)
         

    }
}

extension Common {
    
    static func disclosureIndicator() -> some View {
        
        Image(systemName: "chevron.right")
        .font(.body).foregroundColor(Color(UIColor(hex:"#aaaaaaff")!))
    }
    
    
    static func imagePlaceHolderView() -> some View {
        ZStack {
   
            Circle().fill(Color(UIColor(hex:"#bbbbccff")!)).frame(width: 32, height: 32)
            
            ActivityIndicator().frame(width:24, height: 24).tintColor(.white)
        }
    }
    
}

extension Common {
    
    static func cartBadge(cartViewPresented : Binding <Bool>, total : Int,
                          maxSize : CGSize = CGSize(width: 80, height :50 ),
                          imageSize : CGSize = CGSize(width : 24, height: 20),
                          fontName : String = Theme.fontNameBold, fontSize : CGFloat = 20,
                          fontColor : Color = .white) -> some View {
        
        Button(action :{
            
            withAnimation{
                
                cartViewPresented.wrappedValue = true
            }
            
        }){
      
            HStack {
        
                Text("\(total)").font(.custom(fontName, size: fontSize)).foregroundColor(fontColor)
                    
                Image(systemName: "cart.fill").resizable()
                    .foregroundColor(.white).frame(width:imageSize.width, height:imageSize.height).aspectRatio(contentMode: .fit)
            
            }
            .padding(8)
            .frame(maxWidth: maxSize.width, maxHeight: maxSize.height, alignment: .trailing)
            .background(Theme.commonBgColor)
            .cornerRadius(20)
          
       
        }
      
    }
    
    
    
    static func selectedPaymentMethodView ( name : String?, imageURL : URL? ) -> some View {
        
        HStack(spacing:20) {
            
            //Spacer().frame(width:10)
            
            KFImage(imageURL)
            .resizable()
            .loadDiskFileSynchronously()
            .placeholder(Common.imagePlaceHolderView)
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .aspectRatio(contentMode: .fit)
            .frame(width: 34)
            
            Text(name ?? "")
            .font(.custom(Theme.fontName, size: 15))
            .frame(minWidth: 200, alignment: .leading)
               
            Spacer()
            
            Common.disclosureIndicator()
            
        }.padding().foregroundColor(.black).background(Color(UIColor(hex:"#eeeeeeff")!))
    }
    
    
}


extension Common {
    
    static func generateQRCode(from string: String) -> UIImage? {
        
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle")
    }
    
    
    @ViewBuilder
    static func qrCodeImageView(from string : String, size : CGSize = CGSize(width:120, height:120)) -> some View {
        
        if let img = generateQRCode(from: string){
            
            ZStack {
       
                Rectangle().fill(Color.blue).frame(width: size.width * 1.2,height: size.width * 1.2).cornerRadius(10)
               
                Image(uiImage: img).resizable().scaledToFit().frame(width: size.width,height: size.width)
           
            }
        }
    }
    
}

extension Common {
    
    static let defaultCurrency : String = "MYR"
    
    static let defaultCountry : String = "MY"
}
