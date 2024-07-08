//
//  ServiceConstants.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

public enum Environments: String, Codable {
    case staging = "https://stg.io"
    case production = "https://prod.io"
}

enum ServiceErrors: Error, Hashable {
    case invalidUrlError(String)
    case somethingWentWrong
    case message(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidUrlError(let url):
            "Invalid Url Error \(url)"
        case .somethingWentWrong:
            "Something went wrong"
        case .message(let message):
            message
        }
    }
}

enum QueryItems: String {
    case buster
}

struct URLParamKeys {
    static let buster = "{{BUSTER}}"
}
