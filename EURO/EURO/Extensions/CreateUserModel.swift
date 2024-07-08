//
//  CreateUserModel.swift
//  EURO
//
//  Created by Shounak Jindam on 08/07/24.
//

import Foundation

struct CreateUserModel: Codable {
    let name: String
    let salary: String
    let age: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case salary = "salary"
        case age = "age"
    }
}

struct Employee: Codable {
    let name: String
    let salary: String
    let age: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case salary = "salary"
        case age = "age"
    }
}

struct EmployeeResponse: Codable {
    let status: String
    let data: Employee
    let message: String
}


