//
//  GroupsModel.swift
//  EURO
//
//  Created by Shounak Jindam on 18/06/24.
//

import Foundation
import SwiftUI

struct Group {
    var name: String
    var teams: [Team]
}

struct Team: Hashable {
    var teamName : String
    var fullTeamName : String
    var teamFlag : String
}

struct Predictor {
    var name : String
    var teamName : String
    var flag : String
    var isChecked : Bool
}
