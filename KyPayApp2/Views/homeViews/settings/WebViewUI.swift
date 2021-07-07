//
//  WebViewUI.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 07/07/2021.
//


import SwiftUI
import WebKit

struct WebViewUI : UIViewRepresentable {
    
    @Binding var url : String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        let configuration = WKWebViewConfiguration()
        
        let w =  WKWebView(frame:.zero, configuration: configuration)
    
        w.contentMode = .scaleAspectFit
        w.sizeToFit()
        w.autoresizesSubviews = true
        
        if let url = URL(string: url)  {
        
            w.load( URLRequest(url: url ) )
        }
        return w
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
      
    }
    
    
}
