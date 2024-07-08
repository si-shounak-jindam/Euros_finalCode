//
//  PathType.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

enum PathType {
 
    case dummyUrlforEmployee
    case postUrlforEmployee
    
    private var endPoint: String {
        switch self {
        case .dummyUrlforEmployee:
            return "https://dummy.restapiexample.com/api/v1/employees"
            
        case .postUrlforEmployee:
            return "https://dummy.restapiexample.com/api/v1/create"
        }
    }
    
    var rawValue: String {
        var url: String = endPoint
        switch self {
       
        case .dummyUrlforEmployee, .postUrlforEmployee:
            return url
        }
    }
    
    var getBusterType: BusterHelper.BusterType? {
        if endPoint.contains("/team") || endPoint.contains("/gamedays") || endPoint.contains("/game-card")  {
            return .normal
        } else if endPoint.contains("/private") || endPoint.contains("/public") ||
                    endPoint.contains("create") || endPoint.contains("disjoin") || endPoint.contains("join")   {
            return .particularCase
        } else {
            return .normal
        }
    }
}
