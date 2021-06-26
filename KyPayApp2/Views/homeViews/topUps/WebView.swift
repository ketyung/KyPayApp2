//
//  PaymentRedirectWebView.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 26/06/2021.
//


import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let url : URL?

    func makeUIView(context: Context) -> WKWebView  {
        
        let configuration = WKWebViewConfiguration()
        
        let w =  WKWebView(frame:.zero, configuration: configuration)
        w.contentMode = .scaleAspectFit
        w.sizeToFit()
        w.autoresizesSubviews = true
    
        if let url = url  {
        
            w.load( URLRequest(url: url ) )
        }
        return w
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        /**
        uiView.evaluateJavaScript("document.readyState", completionHandler: { result, error in

            if result == nil || error != nil {
                return
            }

            uiView.evaluateJavaScript("document.body.style.width=400px;")
      
            let js = "document.getElementsByTagName('div')[0].offsetWidth"
                           
            
            uiView.evaluateJavaScript(js, completionHandler: { result, error in
                if let width = result as? CGFloat {
                    
                    print("offset.width::\(width)::\(uiView.frame.width)")
                    
                }
            })
        })*/
    }
    
}

/**
extension PaymentRedirectWebView {
    
    class Coordinator {
        
        
    }
}
 */
