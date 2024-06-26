//
//  GroupsViewModel.swift
//  UEFAGrpStage
//
//  Created by Shounak Jindam on 11/06/24.
//

import Foundation
import SwiftUI
class GroupsViewModel: ObservableObject{
    
    @Published var groupTeamsDictNew : [Group]
    @Published var newTeamsDictNew: [Group]
    @Published var predictorNew : [Predictor]
    @Published var firstPlaceTeams : [Predictor]
    @Published var secondPlaceTeams : [Predictor]
    
    @Published var progressViewCounter : Double = 0
    
    @Published var navigationGroupTitle: String = "Group Stage"
    
    @Published var showKnockoutSheet: Bool = false
    @Published var showKnockoutBracket: Bool = false
    @Published var showBottomSheet: Bool = false
    @Published var popularTeamPrediction: [Team] = [
        Team(teamName: "ALB", fullTeamName: "Albania", teamFlag: "Albania"),
        Team(teamName: "CRO", fullTeamName: "Croatia", teamFlag: "Croatia"),
        Team(teamName: "SUI", fullTeamName: "Switzerland", teamFlag: "Switzerland"),
        Team(teamName: "DEN", fullTeamName: "Denmark", teamFlag: "Denmark")
    ]
    
    init(){
        self.groupTeamsDictNew = [
            Group(name: "A", teams: [
                Team(teamName: "ALB", fullTeamName: "Albania", teamFlag: "Albania"),
                Team(teamName: "CRO", fullTeamName: "Croatia", teamFlag: "Croatia"),
                Team(teamName: "SUI", fullTeamName: "Switzerland", teamFlag: "Switzerland"),
                Team(teamName: "DEN", fullTeamName: "Denmark", teamFlag: "Denmark")
            ]),
            Group(name: "B", teams: [
                Team(teamName: "GER", fullTeamName: "Germany", teamFlag: "Germany"),
                Team(teamName: "FRA", fullTeamName: "France", teamFlag: "France"),
                Team(teamName: "POR", fullTeamName: "Portugal", teamFlag: "Portugal"),
                Team(teamName: "ITA", fullTeamName: "Italy", teamFlag: "Italy")
            ]),
            Group(name: "C", teams: [
                Team(teamName: "ESP", fullTeamName: "Spain", teamFlag: "Spain"),
                Team(teamName: "ENG", fullTeamName: "England", teamFlag: "England"),
                Team(teamName: "BEL", fullTeamName: "Belgium", teamFlag: "Belgium"),
                Team(teamName: "NED", fullTeamName: "Netherlands", teamFlag: "Netherlands")
            ]),
            Group(name: "D", teams: [
                Team(teamName: "POL", fullTeamName: "Poland", teamFlag: "Poland"),
                Team(teamName: "UKR", fullTeamName: "Ukraine", teamFlag: "Ukraine"),
                Team(teamName: "AUT", fullTeamName: "Austria", teamFlag: "Austria"),
                Team(teamName: "TUR", fullTeamName: "Turkey", teamFlag: "Turkey")
            ]),
            Group(name: "E", teams: [
                Team(teamName: "ROM", fullTeamName: "Romania", teamFlag: "Romania"),
                Team(teamName: "SCO", fullTeamName: "Scotland", teamFlag: "Scotland"),
                Team(teamName: "SVO", fullTeamName: "Slovenia", teamFlag: "Slovenia"),
                Team(teamName: "CZE", fullTeamName: "Czechia", teamFlag: "Czechia")
            ]),
            Group(name: "F", teams: [
                Team(teamName: "HUN", fullTeamName: "Hungary", teamFlag: "Hungary"),
                Team(teamName: "GIA", fullTeamName: "Georgia", teamFlag: "Georgia"),
                Team(teamName: "SER", fullTeamName: "Serbia", teamFlag: "Serbia"),
                Team(teamName: "SLO", fullTeamName: "Slovakia", teamFlag: "Slovakia")
            ])
        ]
        
        self.newTeamsDictNew = [
            Group(name: "A", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "B", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "C", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "D", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "E", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ]),
            Group(name: "F", teams: [
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: ""),
                Team(teamName: "", fullTeamName: "", teamFlag: "")
            ])
        ]
        self.firstPlaceTeams = [
            Predictor(name: "A", teamName: "", flag: "", isChecked: false),
            Predictor(name: "B", teamName: "", flag: "", isChecked: false),
            Predictor(name: "C", teamName: "", flag: "", isChecked: false),
            Predictor(name: "D", teamName: "", flag: "", isChecked: false),
            Predictor(name: "E", teamName: "", flag: "", isChecked: false),
            Predictor(name: "F", teamName: "", flag: "", isChecked: false)
        ]
        self.secondPlaceTeams = [
            Predictor(name: "A", teamName: "", flag: "", isChecked: false),
            Predictor(name: "B", teamName: "", flag: "", isChecked: false),
            Predictor(name: "C", teamName: "", flag: "", isChecked: false),
            Predictor(name: "D", teamName: "", flag: "", isChecked: false),
            Predictor(name: "E", teamName: "", flag: "", isChecked: false),
            Predictor(name: "F", teamName: "", flag: "", isChecked: false)
        ]
        
        self.predictorNew = [
            Predictor(name: "A", teamName: "", flag: "", isChecked: false),
            Predictor(name: "B", teamName: "", flag: "", isChecked: false),
            Predictor(name: "C", teamName: "", flag: "", isChecked: false),
            Predictor(name: "D", teamName: "", flag: "", isChecked: false),
            Predictor(name: "E", teamName: "", flag: "", isChecked: false),
            Predictor(name: "F", teamName: "", flag: "", isChecked: false)
        ]
    }

    //MARK: - Functions
    func indexMovedTeam(){
        for (index, group) in newTeamsDictNew.enumerated() {
            
            if group.teams.indices.contains(0) {
                firstPlaceTeams[index].teamName = group.teams[0].fullTeamName
                firstPlaceTeams[index].flag = group.teams[0].teamFlag
            }
            
            if group.teams.indices.contains(1) {
                secondPlaceTeams[index].teamName = group.teams[1].fullTeamName
                secondPlaceTeams[index].flag = group.teams[1].teamFlag
            }
            
            if group.teams.indices.contains(2) {
                predictorNew[index].teamName = group.teams[2].fullTeamName
                predictorNew[index].flag = group.teams[2].teamFlag
            }
            
        }
    }
    
    var checkedItemsCount: Int {
        predictorNew.filter { $0.isChecked }.count
    }
    
    func addTeams(team: Team, groupKey: String) {
        
        if let groupIndex = newTeamsDictNew.firstIndex(where: { $0.name == groupKey }) {
            if let firstEmptyIndex = newTeamsDictNew[groupIndex].teams.firstIndex(where: { $0.teamName.isEmpty && $0.teamFlag.isEmpty }) {
                if !newTeamsDictNew[groupIndex].teams.contains(where: { $0.teamName == team.teamName && $0.teamFlag == team.teamFlag }) {
                    newTeamsDictNew[groupIndex].teams[firstEmptyIndex] = team
                    indexMovedTeam()
                }
            }
        }
    }
    
    func move(team: String, indices: IndexSet, newOffset: Int) {
        guard let index = newTeamsDictNew.firstIndex(where: { $0.name == team }) else {
            return
        }
        
        var group = newTeamsDictNew[index]
        withAnimation {
            group.teams.move(fromOffsets: indices, toOffset: newOffset)
        }
        newTeamsDictNew[index] = group
        
        indexMovedTeam()
    }
    
    func updateNavigationGroupTitle(_ newTitle: String) {
        self.navigationGroupTitle = newTitle
    }
}
