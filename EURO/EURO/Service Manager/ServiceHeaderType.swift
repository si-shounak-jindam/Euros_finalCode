//
//  ServiceHeaderType.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

// MARK: - SERVICE HEADER TYPES
enum ServiceHeaderType: String {
    case NONE
    case DEFAULT
    
    func getServiceHeader(url: String) -> [String: String] {
        switch self {
        case .NONE:
            return [:]
        case .DEFAULT:
            if url.contains("/services") { return [:] }
            return getDefaultHeaders()
        }
    }
    
    private func getDefaultHeaders() -> [String:String] {
        return [
            "Accept" : "application/json",
            "content-type": "application/json"
        ]
    }
}
