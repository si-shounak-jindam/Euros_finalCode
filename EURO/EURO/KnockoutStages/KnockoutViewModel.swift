//
//  KnockoutViewModel.swift
//  EURO
//
//  Created by Shounak Jindam on 27/06/24.
//

import Foundation
import SwiftUI

class KnockoutViewModel: ObservableObject {
    
    init(viewModel: GroupsViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: GroupsViewModel
    @Published var tournamentStages: [String] = ["Round of 16", "Round of 8", "Semi Final", "Final"]
    @Published var winnerLogo: String = ""
    @Published var previouslySelectedTeamsCount: Int = .zero
    @Published var selectedTeams: [[Int: String]] = [[:], [:], [:], [:]]

    
    
    
    @Published var rounds: [[Matches]] = [
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 8),
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 4),
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 2),
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 1)
    ]
    
    
    
    func populateFirstRound() {
        let selectedTeams = viewModel.predictorNew.filter { $0.isChecked }
        guard selectedTeams.count == 4 else {
            print("There must be exactly 4 selected teams")
            return
        }
        
        let selectedThirdPlacedTeams = viewModel.selectedThirdPlacedTeams
        rounds[0] = [
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[0].teamName,
                                teamFlag: viewModel.firstPlaceTeams[0].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[5].teamName,
                                teamFlag: viewModel.secondPlaceTeams[5].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[1].teamName,
                                teamFlag: viewModel.firstPlaceTeams[1].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[4].teamName,
                                teamFlag: viewModel.secondPlaceTeams[4].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[2].teamName,
                                teamFlag: viewModel.firstPlaceTeams[2].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[3].teamName,
                                teamFlag: viewModel.secondPlaceTeams[3].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[3].teamName,
                                teamFlag: viewModel.firstPlaceTeams[3].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[2].teamName,
                                teamFlag: viewModel.secondPlaceTeams[2].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[4].teamName,
                                teamFlag: viewModel.firstPlaceTeams[4].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[1].teamName,
                                teamFlag: viewModel.secondPlaceTeams[1].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[5].teamName,
                                teamFlag: viewModel.firstPlaceTeams[5].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[0].teamName,
                                teamFlag: viewModel.secondPlaceTeams[0].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: selectedTeams[0].teamName,
                                teamFlag: selectedTeams[0].flag),
                    team2: Team(teamName: "", fullTeamName: selectedTeams[1].teamName,
                                teamFlag: selectedTeams[1].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: selectedTeams[2].teamName,
                                teamFlag: selectedTeams[2].flag),
                    team2: Team(teamName: "", fullTeamName: selectedTeams[3].teamName,
                                teamFlag: selectedTeams[3].flag))
        ]
    }
    
    func updateNextRound(roundIndex: Int, matchIndex: Int, team: String) {
        guard roundIndex < rounds.count - 1 else {
            if roundIndex == rounds.count - 1 {
                winnerLogo = team
            }
            return
        }
        
        let nextRoundMatchIndex = matchIndex / 2
        
        if matchIndex % 2 == 0 {
            rounds[roundIndex + 1][nextRoundMatchIndex].team1 = Team(teamName: "", fullTeamName: team,
                                                                     teamFlag: team)
        } else {
            rounds[roundIndex + 1][nextRoundMatchIndex].team2 = Team(teamName: "", fullTeamName: team,
                                                                     teamFlag: team)
        }
    }
    
    func updateProgressForKnockout() {
        let totalSelectedTeams = selectedTeams.flatMap{ $0 }.map{ !$0.value.isEmpty }.filter{ $0 }.count
        if totalSelectedTeams > previouslySelectedTeamsCount {
            viewModel.progressViewCounter += 1/43
        } else {
            if totalSelectedTeams == previouslySelectedTeamsCount { } else {
                viewModel.progressViewCounter -= 1/43
            }
        }
        previouslySelectedTeamsCount = totalSelectedTeams
    }
    
    
    
    
}
