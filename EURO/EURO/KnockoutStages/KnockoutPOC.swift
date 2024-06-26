//
//  KnockoutStages.swift
//  EURO
//
//  Created by Shounak Jindam on 20/06/24.

import SwiftUI

struct MatchColumnView: View {
    let elements: Int
    let rounds: [Matches]
    @Binding var selectedTeams: [Int: String]
    let spacing: (Int) -> CGFloat
    let onTeamSelected: (Int, String) -> Void
    @Binding var winnerLogo: String
    
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            Spacer()
            ForEach(0..<elements, id: \.self) { index in
                if !winnerLogo.isEmpty && rounds.count == 1 {
                    HStack {
                        Image(winnerLogo)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        
                        FANTASYTheme.getImage(named: .Trophy)?
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                    .padding(10)
                    .padding(.top, -170)
                }
                MatchView(
                    showLeftLine: elements != 8,
                    showRightLine: elements != 1,
                    spacing: elements == 1 ? .zero : spacing(elements),
                    index: index,
                    match: rounds[index],
                    teamOneSelection: Binding(get: {
                        selectedTeams[index * 2] ?? ""
                    }, set: { newValue in
                        selectedTeams[index * 2] = newValue
                        selectedTeams[index * 2 + 1] = ""
                        onTeamSelected(index, newValue)
                    }),
                    teamTwoSelection: Binding(get: {
                        selectedTeams[index * 2 + 1] ?? ""
                    }, set: { newValue in
                        selectedTeams[index * 2 + 1] = newValue
                        selectedTeams[index * 2] = ""
                        onTeamSelected(index, newValue)
                    })
                )
            }
            Spacer()
        }
        .frame(minHeight: UIScreen.main.bounds.height)
        .background (
            HStack {
                Color.clear.frame(width: 1).id(elements)
                Spacer()
            }
                .padding(.leading, -25)
        )
    }
}


import SwiftUI

struct KnockoutPOC: View {
    //@Binding var progress: Double
    @ObservedObject var viewModel: GroupsViewModel
    @State private var selectedTeams: [[Int: String]] = [[:], [:], [:], [:]]
    
    @State private var rounds: [[Matches]] = [
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 8),
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 4),
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 2),
        Array(repeating: Matches(team1: Team(teamName: "", fullTeamName: "", teamFlag: ""),
                                 team2: Team(teamName: "", fullTeamName: "", teamFlag: "")), count: 1)
    ]
    
    @State private var offset: CGFloat = .zero
    @State private var currentOffset: CGFloat = .zero
    @State private var additionalSpacing: Int = .zero
    @State private var winnerLogo: String = ""
    @State private var previouslySelectedTeamsCount: Int = .zero
    let tournamentStages: [String] = ["Round of 16", "Round of 8", "Semi Final", "Final"]
    
    func spacing(elements: Int) -> CGFloat {
        (ColumnSpacing(rawValue: elements)?.spacing ?? ColumnSpacing.defaultSpace.spacing) - (CGFloat(additionalSpacing/elements))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            VStack(spacing: .zero) {
                NavigationBar(viewModel: viewModel)
                    .frame(height: 80)
                    .ignoresSafeArea(.all,edges: .top)
                SponsorView()
                    .padding(.top, 30)
//                ProgressView(value: Double(viewModel.progressViewCounter), total: 35)
//                    .accentColor(.yellow)
//                    .progressViewStyle(.linear)
//                    .padding([.horizontal, .top], 15)
                    
                ProgressBar(progress: $viewModel.progressViewCounter)
            }
            .background(Color.scrollBg)
            .onAppear {
                viewModel.updateNavigationGroupTitle("My Bracket")
            }
            
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    HStack(alignment: .center, spacing: .zero) {
                        ForEach(0..<rounds.count, id: \.self) { roundIndex in
                            VStack(alignment: .center, spacing: .zero) {
                                Spacer()
                                Text(tournamentStages[roundIndex])
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                var selected: Binding<[Int:String]> {
                                    Binding {
                                        selectedTeams[roundIndex]
                                    } set: { value in
                                        selectedTeams[roundIndex] = value
                                    }
                                }
                                
                                MatchColumnView(
                                    elements: rounds[roundIndex].count,
                                    rounds: rounds[roundIndex],
                                    selectedTeams: selected,
                                    spacing: spacing,
                                    onTeamSelected: { matchIndex, team in
                                        updateNextRound(roundIndex: roundIndex,
                                                        matchIndex: matchIndex,
                                                        team: team)
                                    },
                                    winnerLogo: $winnerLogo
                                )
                            }
                        }
                    }
                    .background(Color.scrollBg)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation {
                                    self.offset = currentOffset + gesture.translation.width
                                }
                            }
                            .onEnded { gesture in
                                withAnimation {
                                    offset = currentOffset
                                    if gesture.translation.width < .zero {
                                        if gesture.translation.width > -100 { } else {
                                            withAnimation {
                                                if offset == -300 {
                                                    self.offset = -625
                                                } else if offset == -625 {
                                                    self.offset = -950
                                                } else {
                                                    self.offset = -300
                                                }
                                                currentOffset = offset
                                            }
                                        }
                                    } else {
                                        if gesture.translation.width > 100 {
                                            withAnimation {
                                                if offset == -950 {
                                                    offset = -625
                                                } else if offset == -625 {
                                                    offset = -300
                                                } else {
                                                    offset = .zero
                                                }
                                                currentOffset = offset
                                            }
                                        }
                                    }
                                }
                            }
                    )
                }
            }
            .edgesIgnoringSafeArea(.all)
            .background(Color.scrollBg)
            .onChange(of: currentOffset) { newValue in
                withAnimation {
                    if newValue == -300 {
                        additionalSpacing = 200
                    } else if newValue == -625 {
                        additionalSpacing = 400
                    } else if newValue == -950 {
                        additionalSpacing = 400
                    } else {
                        additionalSpacing = .zero
                    }
                }
            }
        }
        .onChange(of: selectedTeams) { value in
            
            let totalSelectedTeams = selectedTeams.flatMap{ $0 }.map{ !$0.value.isEmpty }.filter{ $0 }.count
            if totalSelectedTeams > previouslySelectedTeamsCount {
                viewModel.progressViewCounter += 1/35
            } else {
                if totalSelectedTeams == previouslySelectedTeamsCount { } else {
                    viewModel.progressViewCounter -= 1/35
                }
            }
            previouslySelectedTeamsCount = totalSelectedTeams
        }
        .onAppear {
            populateFirstRound()
        }
    }
    
    
    
    private func populateFirstRound() {
        rounds[0] = [
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[0].teamName, 
                                teamFlag: viewModel.firstPlaceTeams[0].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[5].teamName,
                                teamFlag: viewModel.secondPlaceTeams[5].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[1].teamName,
                                teamFlag: viewModel.firstPlaceTeams[1].teamName),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[4].teamName,
                                teamFlag: viewModel.secondPlaceTeams[4].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[2].teamName,
                                teamFlag: viewModel.firstPlaceTeams[2].teamName),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[3].teamName,
                                teamFlag: viewModel.secondPlaceTeams[3].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[3].teamName,
                                teamFlag: viewModel.firstPlaceTeams[3].teamName),
                    team2:Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[2].teamName,
                               teamFlag: viewModel.secondPlaceTeams[2].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[4].teamName,
                                teamFlag: viewModel.firstPlaceTeams[4].teamName),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[1].teamName,
                                teamFlag: viewModel.secondPlaceTeams[1].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.firstPlaceTeams[5].teamName,
                                teamFlag: viewModel.firstPlaceTeams[5].teamName),
                    team2: Team(teamName: "", fullTeamName: viewModel.secondPlaceTeams[0].teamName,
                                teamFlag: viewModel.secondPlaceTeams[0].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.predictorNew[0].teamName,
                                teamFlag: viewModel.predictorNew[0].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.predictorNew[1].teamName,
                                teamFlag: viewModel.predictorNew[1].flag)),
            Matches(team1: Team(teamName: "", fullTeamName: viewModel.predictorNew[2].teamName,
                                teamFlag: viewModel.predictorNew[2].flag),
                    team2: Team(teamName: "", fullTeamName: viewModel.predictorNew[3].teamName,
                                teamFlag: viewModel.predictorNew[3].flag)),
        ]
    }
    
    private func updateNextRound(roundIndex: Int, matchIndex: Int, team: String) {
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
}


