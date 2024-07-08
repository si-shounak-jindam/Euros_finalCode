//
//  GroupsFooterView.swift
//  EURO
//
//  Created by Shounak Jindam on 27/06/24.
//

import SwiftUI

struct GroupsFooterView: View {
    var index: Int
    @ObservedObject var viewModel: GroupsViewModel
    @StateObject var scoreSheetViewModel: ScoreSheetViewModel
    @State private var employee = Employee(name: "John Doe", salary: "1234", age: "30")
    @State private var responseMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        let groupKey = viewModel.groupTeamsDictNew[index].name
        let teams = viewModel.groupTeamsDictNew[index].teams
        HStack {
            Spacer()
            Button("View Group \(groupKey) details") {
                viewModel.showBottomSheet.toggle()
            }
            .foregroundColor(.yellow)
            Spacer()
        }
        .padding()
        .background(Color(hex: 0x112f81))
        .fullScreenCover(isPresented: $viewModel.showBottomSheet,
                         content: {
            bottomSheet
                .clearModalBackground()
        })
        .background(
            FANTASYTheme.getColor(named: .groupSheetBlue)
        )
    }
    
    //bottomSheet
    var bottomSheet: some View {
        VStack(spacing: 0) {
            let groupKey = viewModel.groupTeamsDictNew[index].name
            let teams = viewModel.groupTeamsDictNew[index].teams
            Spacer()
            VStack {
                HStack {
                    Text("Most popular Group \(groupKey) prediction")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding([.top, .leading], 10)
                    Spacer()
                    Button(action: {
                        viewModel.showBottomSheet = false
                    }, label: {
                        Image(systemName: "xmark")
                            .accentColor(.white)
                            .padding([.top, .trailing], 10)
                    })
                }
                .background(
                    FANTASYTheme.getColor(named: .groupSheetBlue)
                )
                VStack {
                    ForEach(viewModel.popularTeamPrediction.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Image(viewModel.popularTeamPrediction[index].teamFlag)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            Text(viewModel.popularTeamPrediction[index].teamName)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        Divider()
                            .background(
                                Color.white.opacity(0.5)
                            )
                    }
                    Divider()
                    HStack {
                        Button(action: {
                            
                            Task {
                                await viewModel.validateUser(name: "test123", salary: "23000", age: "23")
                            }
                                scoreSheetViewModel.showScoreSheet.toggle()
                        }, label: {
                            Text("See how to score points")
                                .foregroundColor(.cfsdkAccent1)
                        })
                        .padding(.bottom, 30)
                        .padding(.leading, 20)
                        Spacer()
                    }
                    .sheet(isPresented: $scoreSheetViewModel.showScoreSheet, content: {
                        ScorePointSheet()
                            .clearModalBackground()
                    })
                }
            }
            .background(FANTASYTheme.getColor(named: .groupSheetBlue))
            .CFSDKcornerRadius(20, corners: [.topLeft, .topRight])
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

