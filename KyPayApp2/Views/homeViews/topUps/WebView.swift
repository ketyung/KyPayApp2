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
    
        //UserDefaults.standard.register(defaults: ["UserAgent" : "Chrome Safari"])
        
        //WKWebView.clearWebCache()
        
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
        
        uiView.evaluateJavaScript("document.readyState", completionHandler: { result, error in

            if result == nil || error != nil {
                return
            }

            let js = "document.getElementById('testing_payment_field_of_id').innerHTML;"
            
            uiView.evaluateJavaScript(js, completionHandler: { result, error in
                
                print("res::\(String(describing: result))")
                if let val = result as? String {
                    
                    print("obtained.value::\(val)")
                    
                }
            })
        })
    }
    
}


extension WKWebView {
    
    class func clearWebCache(){
        let websiteDataTypes = NSSet(array: [
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeOfflineWebApplicationCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeLocalStorage,
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeSessionStorage,
            WKWebsiteDataTypeIndexedDBDatabases,
            WKWebsiteDataTypeWebSQLDatabases])
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
}

/**extension PaymentRedirectWebView {
    
    class Coordinator : WKNavigationDelegate{
        
    }
}*/

