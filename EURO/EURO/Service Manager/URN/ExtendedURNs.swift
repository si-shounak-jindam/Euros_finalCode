//
//  ExtendedURNs.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation



struct EmployeeURN: CommonGetURN {
    typealias Derived = EmployeeDataModel
    
    var baseURLType: BaseURLType {
        .none
    }
    
    
    var pathType: PathType {
        .dummyUrlforEmployee
    }
}

struct EmployeePostURN: CommonPostURN {
    typealias Derived = Employee
    
    var baseURLType: BaseURLType {
        .none
    }
    
    var pathType: PathType {
        .postUrlforEmployee
    }
    
    var body: Data?
    
    var headers: ServiceHeaderType? {
        .DEFAULT
    }
}
