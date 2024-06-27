//
//  GroupListView.swift
//  EURO
//
//  Created by Shounak Jindam on 27/06/24.
//

import SwiftUI

struct GroupsListView: View {
    var index: Int
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        let groupKey = viewModel.newTeamsDictNew[index].name
        let teams = viewModel.newTeamsDictNew[index].teams
        
        List {
            ForEach(teams.indices, id: \.self) { teamIndex in
                VStack(alignment: .leading, spacing: 13) {
                    HStack(spacing: 20) {
                        Text("\(teamIndex + 1)")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 10)
                        
                        Image(teams[teamIndex].teamFlag)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(25)
                            .overlay(
                                teams[teamIndex].teamFlag != "" ? RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white, lineWidth: 2) : nil
                            )
                            .padding(.vertical,2.5)
                        
                        Text(teams[teamIndex].fullTeamName)
                            .foregroundColor(Color.white)
                        
                    }
                }
                .listRowBackground(Color(hex: 0x101d6b))
            }
            .onMove { indices, newOffset in
                viewModel.move(team: groupKey, indices: indices, newOffset: newOffset)
            }
            
        }
        .frame(height: 263)
        .environment(\.editMode, .constant(.active))
        .listStyle(.plain)
        
    }
}
