//
//  GroupViewModel.swift
//  EURO
//
//  Created by Shounak Jindam on 13/06/24.
//


//import SwiftUI
//
//class GroupsViewModel: ObservableObject{
//    
//    @Published var groupTeamsDictNew : [Groups]
//    @Published var newTeamsDictNew: [Groups]
//    @Published var predictorNew : [Predictor]
//    @Published var progressViewCounter : Int = 0
//    
//    init(){
//        self.groupTeamsDictNew = [
//            Group(name: "A", teams: [
//                Team(teamName: "ALB", fullTeamName: "Albania", teamFlag: "Albania"),
//                Team(teamName: "CRO", fullTeamName: "Croatia", teamFlag: "Croatia"),
//                Team(teamName: "SUI", fullTeamName: "Switzerland", teamFlag: "Switzerland"),
//                Team(teamName: "DEN", fullTeamName: "Denmark", teamFlag: "Denmark")
//            ]),
//            Group(name: "B", teams: [
//                Team(teamName: "GER", fullTeamName: "Germany", teamFlag: "Germany"),
//                Team(teamName: "FRA", fullTeamName: "France", teamFlag: "France"),
//                Team(teamName: "POR", fullTeamName: "Portugal", teamFlag: "Portugal"),
//                Team(teamName: "ITA", fullTeamName: "Italy", teamFlag: "Italy")
//            ]),
//            Group(name: "C", teams: [
//                Team(teamName: "ESP", fullTeamName: "Spain", teamFlag: "Spain"),
//                Team(teamName: "ENG", fullTeamName: "England", teamFlag: "England"),
//                Team(teamName: "BEL", fullTeamName: "Belgium", teamFlag: "Belgium"),
//                Team(teamName: "NED", fullTeamName: "Netherlands", teamFlag: "Netherlands")
//            ]),
//            Group(name: "D", teams: [
//                Team(teamName: "POL", fullTeamName: "Poland", teamFlag: "Poland"),
//                Team(teamName: "UKR", fullTeamName: "Ukraine", teamFlag: "Ukraine"),
//                Team(teamName: "AUT", fullTeamName: "Austria", teamFlag: "Austria"),
//                Team(teamName: "TUR", fullTeamName: "Turkey", teamFlag: "Turkey")
//            ]),
//            Group(name: "E", teams: [
//                Team(teamName: "ROM", fullTeamName: "Romaina", teamFlag: "Romaina"),
//                Team(teamName: "SCO", fullTeamName: "Scotland", teamFlag: "Scotland"),
//                Team(teamName: "SVO", fullTeamName: "Slovenia", teamFlag: "Slovenia"),
//                Team(teamName: "CZE", fullTeamName: "Czechia", teamFlag: "Czechia")
//            ]),
//            Group(name: "F", teams: [
//                Team(teamName: "HUN", fullTeamName: "Hungary", teamFlag: "Hungary"),
//                Team(teamName: "GIA", fullTeamName: "Georgia", teamFlag: "Georgia"),
//                Team(teamName: "SER", fullTeamName: "Serbia", teamFlag: "Serbia"),
//                Team(teamName: "SLO", fullTeamName: "Slovakia", teamFlag: "Slovakia")
//            ])
//        ]
//        
//        self.newTeamsDictNew = [
//            Group(name: "A", teams: [
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: "")
//            ]),
//            Group(name: "B", teams: [
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: "")
//            ]),
//            Group(name: "C", teams: [
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: "")
//            ]),
//            Group(name: "D", teams: [
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: "")
//            ]),
//            Group(name: "E", teams: [
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: "")
//            ]),
//            Group(name: "F", teams: [
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: ""),
//                Team(teamName: "", fullTeamName: "", teamFlag: "")
//            ])
//        ]
//        
//        self.predictorNew = [
//            Predictor(name: "A", teamName: "", flag: "", isChecked: false),
//            Predictor(name: "B", teamName: "", flag: "", isChecked: false),
//            Predictor(name: "C", teamName: "", flag: "", isChecked: false),
//            Predictor(name: "D", teamName: "", flag: "", isChecked: false),
//            Predictor(name: "E", teamName: "", flag: "", isChecked: false),
//            Predictor(name: "F", teamName: "", flag: "", isChecked: false)
//        ]
//    }
//
//    //MARK: - Functions
//    func indexMovedTeam(){
//        for (index, group) in newTeamsDictNew.enumerated() {
//            if group.teams.indices.contains(2) {
//                predictorNew[index].teamName = group.teams[2].fullTeamName
//                predictorNew[index].flag = group.teams[2].teamFlag
//            }
//        }
//    }
//    
//    var checkedItemsCount: Int {
//        predictorNew.filter { $0.isChecked }.count
//    }
//    
//    func addTeams(team: Team, groupKey: String) {
//        
//        if let groupIndex = newTeamsDictNew.firstIndex(where: { $0.name == groupKey }) {
//            if let firstEmptyIndex = newTeamsDictNew[groupIndex].teams.firstIndex(where: { $0.teamName.isEmpty && $0.teamFlag.isEmpty }) {
//                if !newTeamsDictNew[groupIndex].teams.contains(where: { $0.teamName == team.teamName && $0.teamFlag == team.teamFlag }) {
//                    newTeamsDictNew[groupIndex].teams[firstEmptyIndex] = team
//                    indexMovedTeam()
//                }
//            }
//        }
//    }
//    
//    func move(team: String, indices: IndexSet, newOffset: Int) {
//        guard let index = newTeamsDictNew.firstIndex(where: { $0.name == team }) else {
//            return
//        }
//        
//        var group = newTeamsDictNew[index]
//        withAnimation {
//            group.teams.move(fromOffsets: indices, toOffset: newOffset)
//        }
//        newTeamsDictNew[index] = group
//        
//        indexMovedTeam()
//    }
//}

