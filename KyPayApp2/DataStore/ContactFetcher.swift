//
//  ContactFetcher.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import Foundation
import ContactsUI


struct Contact {
    
    var cnIdentifier : String = ""
    
    var firstName : String = ""
    
    var lastName : String = ""
    
    var phoneNumber : String = ""
    
    var name : String {
        
        "\(firstName) \(lastName)"
    }
}

class ContactFetcher : NSObject {
    
    
    class func getContacts() -> [Contact] { //  ContactsFilter is Enum find it below

        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey,
        ] as [Any]

    
        var results: [Contact] = []

    
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        request.sortOrder = CNContactSortOrder.givenName
        
        do {
            
            try contactStore.enumerateContacts(with: request){
                    (contact, stop) in
                // Array containing all unified contacts from everywhere
                
                if let cont = cnContactToContact(contact) {
               
                    results.append(cont)
                   
                }
                
            }
            
        } catch {
            print("unable to fetch contacts")
        }
        
        return results
    }
    
    
    
    private class func cnContactToContact (_ contact : CNContact) -> Contact? {
        
        
        for num in contact.phoneNumbers
        {
             if num.label == "_$!<Mobile>!$_"
             {
                
                let cc = (num.value.value(forKey: "countryCode") as? String ?? "").uppercased()
                
                let dialCode = Country.dialCode(countryCode: cc)
                
                let phoneNum = (num.value.value(forKey: "digits") as? String ?? "").deletingPrefix(dialCode).deletingPrefix("0")
                
                
                let contact = Contact(cnIdentifier: contact.identifier, firstName:contact.givenName, lastName: contact.familyName, phoneNumber: "\(dialCode)\(phoneNum)")
                
                return contact
             }
            
        }

        return nil
    }
}

