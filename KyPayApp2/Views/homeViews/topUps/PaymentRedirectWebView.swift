//
//  PaymentRedirectWebView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 26/06/2021.
//


import SwiftUI
import WebKit

struct PaymentRedirectWebView : UIViewRepresentable {
    
    let url : URL?

    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView(frame: CGRect(x:10, y:0, width: UIScreen.main.bounds.width - 20 , height : UIScreen.main.bounds.height))
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        if let url = url  {
        
            uiView.load( URLRequest(url: url ) )
        }
    }
    
}
