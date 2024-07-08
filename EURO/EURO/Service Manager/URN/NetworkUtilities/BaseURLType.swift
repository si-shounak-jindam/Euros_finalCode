//
//  BaseURLType.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

enum BaseURLType {
    case base
    case none
    
    var baseUrlString: String {
        switch self {
        case .base:
            return String()
        case .none:
            return String()
        }
    }
}
