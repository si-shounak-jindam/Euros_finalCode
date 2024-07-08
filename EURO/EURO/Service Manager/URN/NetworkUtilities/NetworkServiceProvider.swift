//
//  NetworkServiceProvider.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

protocol NetworkServiceProvider {
    associatedtype URNType

    func execute<URNType: URN>(with urnType: URNType) async throws -> URNType.Derived
}
