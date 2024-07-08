//
//  Utils.swift
//  EURO
//
//  Created by Shounak Jindam on 03/07/24.
//


import Foundation


final class Utils: ObservableObject {
    static let shared = Utils()
    
    @Published var configData: Config?

}


