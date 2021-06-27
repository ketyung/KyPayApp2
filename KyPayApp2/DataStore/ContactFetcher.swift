//
//  ContactFetcher.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 17/06/2021.
//

import Foundation
import ContactsUI


struct Contact : Equatable{
    
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
           // CNContactThumbnailImageDataKey,
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

extension ContactFetcher {
    
    
    class func getContact(by identifier : String) -> Contact?{
        
        let keysToFetch = [
            CNContactGivenNameKey, CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey
        ]
      
        do {
       
            let predicate: NSPredicate = CNContact.predicateForContacts(withIdentifiers: [identifier])
            let contacts = try CNContactStore().unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
    
            if let contact = contacts.first {
                
               // print("found::1:\(contact.familyName)")
                return cnContactToContact(contact)
                
            }
            return nil
    
        }
        catch{
            
            print("err:\(error)")
            return nil
        }
    }
}
