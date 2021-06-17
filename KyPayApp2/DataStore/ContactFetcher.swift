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
}

class ContactFetcher : NSObject {
    

    enum ContactsFilter {
       case none
       case mail
       case message
    }
    
    class func getContacts() -> [CNContact] { //  ContactsFilter is Enum find it below

        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey,
        ] as [Any]

    
        var results: [CNContact] = []

    
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        request.sortOrder = CNContactSortOrder.givenName
        
        do {
            
            try contactStore.enumerateContacts(with: request){
                    (contact, stop) in
                // Array containing all unified contacts from everywhere
                results.append(contact)
                
            }
            
        } catch {
            print("unable to fetch contacts")
        }
        
        return results
    }
    
    
    
    private func doesContactHaveMobile (_ contact : CNContact)  {
        
        
        for num in contact.phoneNumbers
        {
             if num.label == "_$!<Mobile>!$_"
             {
                
                return 
             }
            
        }

    }
}

