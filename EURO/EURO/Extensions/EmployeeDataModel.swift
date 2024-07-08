//
//  DummyModel.swift
//  EURO
//
//  Created by Shounak Jindam on 03/07/24.
//

import Foundation
import SwiftUI

struct EmployeeDataModel: Codable {
    let status: String?
    let data: [Datum]?
    let message: String?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let employeeName: String?
    let employeeSalary, employeeAge: Int?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
