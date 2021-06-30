//
//  DeviceToken.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 30/06/2021.
//

import Foundation

struct DeviceToken : Codable {
    
    var id : String?
    
    var token : String?
    
    var deviceType : String = "I"
    
    var lastUpdated : Date?
    
}
