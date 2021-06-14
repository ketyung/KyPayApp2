//
//  Extensions.swift
//  KyPayApp2
//
//  Created by Chee Ket Yung on 14/06/2021.
//

import Foundation
import UIKit

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
}

