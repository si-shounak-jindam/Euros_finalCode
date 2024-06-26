//
//  KnockoutModel.swift
//  EURO
//
//  Created by Shounak Jindam on 24/06/24.
//

import SwiftUI

struct Matches: Hashable, Equatable {
    
    let id = UUID()
    var team1: Team?
    var team2: Team?
}

struct MatchSet {
    let set: [Matches]
}

