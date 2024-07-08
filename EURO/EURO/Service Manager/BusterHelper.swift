//
//  BusterHelper.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

class BusterHelper {
    static let shared = BusterHelper()
    
    // Variables
    private var mixApiBuster: String = String()
    
    enum BusterType {
        case normal
        case particularCase
    }
    
    init() {
        mixApiBuster = getBusterUpdatedValue()
    }
    
    private func getBusterUpdatedValue() -> String {
        "\(Date().timeIntervalSince1970.rounded())"
    }
    
    /// BusterUpdation
    /// - Parameters:
    ///   - type: pass the type that you declare in the BusterType enum
    ///   - mark: Update the functionality as required according to the cases added in BusterType
    func updateBuster(type: BusterType? = nil, types: [BusterType] = []) {
        if types.count == .zero, let type = type {
            switch type {
            case .normal:
                mixApiBuster = getBusterUpdatedValue()
            case .particularCase:
                mixApiBuster = getBusterUpdatedValue()
            }
        } else {
            types.forEach { type in
                switch type {
                case .normal:
                    mixApiBuster = getBusterUpdatedValue()
                case .particularCase:
                    mixApiBuster = getBusterUpdatedValue()
                }
            }
        }
    }
    
    func getBusterFor(type: BusterType) -> String {
        switch type {
        case .normal:
            mixApiBuster
        case .particularCase:
            mixApiBuster
        }
    }
}
