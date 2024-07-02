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
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        FANTASYTheme.getImage(named: .Trophy)?
                            .resizable()
                            .frame(width: 150, height: 220)
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
    
    @ObservedObject var viewModel: GroupsViewModel
    @StateObject var knockoutViewModel: KnockoutViewModel
    
    
    
    @State private var offset: CGFloat = .zero
    @State private var currentOffset: CGFloat = .zero
    @State private var additionalSpacing: Int = .zero
    
    
   
    
    func spacing(elements: Int) -> CGFloat {
        (ColumnSpacing(rawValue: elements)?.spacing ?? ColumnSpacing.defaultSpace.spacing) - (CGFloat(additionalSpacing/elements))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            VStack(spacing: .zero) {
                NavigationBar(viewModel: viewModel)
                    .ignoresSafeArea(.all,edges: .top)
            }
            .onAppear {
                viewModel.updateNavigationGroupTitle("My Bracket")
            }
            
            VStack {
                SponsorView()
                ProgressBar(progress: $viewModel.progressViewCounter)
            }
            .background(Color.scrollBg)
            
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    HStack(alignment: .center, spacing: .zero) {
                        ForEach(0..<knockoutViewModel.rounds.count, id: \.self) { roundIndex in
                            VStack(alignment: .center, spacing: .zero) {
                                Spacer()
                                Text(knockoutViewModel.tournamentStages[roundIndex])
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                var selected: Binding<[Int:String]> {
                                    Binding {
                                        knockoutViewModel.selectedTeams[roundIndex]
                                    } set: { value in
                                        knockoutViewModel.selectedTeams[roundIndex] = value
                                    }
                                }
                                
                                MatchColumnView(
                                    elements: knockoutViewModel.rounds[roundIndex].count,
                                    rounds: knockoutViewModel.rounds[roundIndex],
                                    selectedTeams: selected,
                                    spacing: spacing,
                                    onTeamSelected: { matchIndex, team in
                                        knockoutViewModel.updateNextRound(roundIndex: roundIndex,
                                                        matchIndex: matchIndex,
                                                        team: team)
                                    },
                                    winnerLogo: $knockoutViewModel.winnerLogo
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
        .background(Color.scrollBg)
        .ignoresSafeArea(.all,edges: .vertical)
        .onChange(of: knockoutViewModel.selectedTeams) { value in
            knockoutViewModel.updateProgressForKnockout()
           
        }
        .onAppear {
            knockoutViewModel.populateFirstRound()
        }
    }
}


