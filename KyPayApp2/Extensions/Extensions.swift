//
//  Extensions.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import UIKit
import WebKit
import SwiftUI

extension Collection {
  
    subscript(safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}


extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func deg2rad() -> Double {
        return self * .pi / 180
    }
    
    
    var twoDecimalString:String {
        return String(format: "%.2f", self)
    }

}


extension Bundle {
    
    func decodeJson <T:Decodable> (_ type : T.Type ,fileName : String,
     dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
     keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) -> T {
        
         guard let url = self.url(forResource: fileName, withExtension: nil) else {
             fatalError("Failed to load file ")
         }
            
         do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
                
            let result = try decoder.decode(type, from: jsonData)
            return result
         }
         catch {
            fatalError("err:\(error)")
         }
  }
}

extension Date {
    
    func isMoreThan(years : Int) -> Bool {
        
        let d = self.timeIntervalSinceNow
        let yrs = -(Double(3600*24*365*years))
        
        return  d < yrs
    }
    
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }

}



extension String {
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    func trim() -> String {
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
      
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func replace(_ word : String, _ with : String) -> String{
        
        return self.replacingOccurrences(of: word, with: with)
    }

    func separate(every stride: Int = 4, with separator: Character = " ") -> String {
        return String(enumerated().map { $0 > 0 && $0 % stride == 0 ? [separator, $1] : [$1]}.joined())
    }
    
    func random(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension LocalizedError where Self: CustomStringConvertible {

   var errorDescription: String? {
      return description
   }
}


extension String {
    
    enum CardType : String {
        
        case master
        case visa
        case amex
        case diners
        case discover
        case jcb
        case none
    }
    
    
    func isMatch(_ Regex: String) -> Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: Regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }.count > 0
        } catch {
            return false
        }
        
    }
    
    func getCreditCardType() -> CardType {
        
        let VISA_Regex = "^4[0-9]{6,}$"
        let MasterCard_Regex = "^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"
        let AmericanExpress_Regex = "^3[47][0-9]{5,}$"
        let DinersClub_Regex = "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        let Discover_Regex = "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        let JCB_Regex = "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        
        if self.isMatch(VISA_Regex) {
            return .visa
        }
        else if self.isMatch(MasterCard_Regex) {
            return .master
        }
        else if self.isMatch(AmericanExpress_Regex) {
            return .amex
        }
        else if self.isMatch(DinersClub_Regex) {
            return .diners
        }
        else if self.isMatch(Discover_Regex) {
            return .discover
        }
        else if self.isMatch(JCB_Regex) {
            return .jcb
        }
        else {
            return .none
        }
        
    }
    
}


extension Array where Element: Equatable {

    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
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


extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


extension Dictionary {
    mutating func switchKey(fromKey: Key, toKey: Key) {
        if let entry = removeValue(forKey: fromKey) {
            self[toKey] = entry
        }
    }
}


extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0")"
    }
    
    var appName: String {
        return infoDictionary?["CFBundleName"] as? String ?? "KyPay"
    }
}
