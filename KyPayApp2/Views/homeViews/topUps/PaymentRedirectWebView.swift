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
    
    @EnvironmentObject private var topUpViewModel : TopUpPaymentViewModel
   

    func makeUIView(context: Context) -> WKWebView  {
        
        let configuration = WKWebViewConfiguration()
    
        //UserDefaults.standard.register(defaults: ["UserAgent" : "Chrome Safari"])
        
        //WKWebView.clearWebCache()
        
        let w =  WKWebView(frame:.zero, configuration: configuration)
    
        w.contentMode = .scaleAspectFit
        w.sizeToFit()
        w.autoresizesSubviews = true
        w.navigationDelegate = topUpViewModel
        
        if let url = url  {
        
            w.load( URLRequest(url: url ) )
        }
        return w
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
      
    }
    
    
}


/**
 extension PaymentRedirectWebView {
    
    class Coordinator : NSObject, WKNavigationDelegate{

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //self.evaluateJs(webView)
            
            print("url:::\(webView.url?.absoluteString ?? "xx/na")")
            
            if webView.url?.absoluteString == WalletHandler.completionURL {
                
                print("success!")
            }
            else if webView.url?.absoluteString == WalletHandler.errorURL {
                
                print("err")
            }
        }
        
        
        private func evaluateJs( _ uiView : WKWebView){
            
            uiView.evaluateJavaScript("document.readyState", completionHandler: { result, error in

                if result == nil || error != nil {
                    return
                }

                let js = "document.getElementById('testing_payment_data').innerHTML"
                
                
                uiView.evaluateJavaScript(js, completionHandler: { result, error in
                    
                    if let v = result as? String {
                        
                        print("V::\(v)")
                    }
                })
            })
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}*/


