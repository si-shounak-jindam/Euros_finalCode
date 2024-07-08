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
//        let groupKey = viewModel.newTeamsDictNew[index].name
//        let teams = viewModel.newTeamsDictNew[index].teams
        
        List {
            ForEach(viewModel.dummyData?.data ?? [], id: \.id) { data in
                VStack(alignment: .leading, spacing: 13) {
                    HStack(spacing: 20) {
                        Text("\((data.id + 1))")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .frame(width: 10)
                        
//                        Image(teams[0].teamFlag)
//                            .resizable()
//                            .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 35,
//                                   height: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 35)
//                            .background(Color.gray.opacity(0.5))
//                            .overlay(
//                                teams[0].teamFlag != "" ? Circle()
//                                    .stroke(Color.white, lineWidth: 2) : nil
//                            )
//                            .padding(.vertical,2.5)
//                            .clipShape(.circle)
                        
                        Text(data.employeeName ?? "")
                            .foregroundColor(Color.white)
                        
                    }
                }
                .listRowBackground(Color(hex: 0x101d6b))
            }
//            .onMove { indices, newOffset in
//                viewModel.move(team: groupKey, indices: indices, newOffset: newOffset)
//            }
            
        }
        .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 360 : 263)
        .environment(\.editMode, .constant(.active))
        .listStyle(.plain)
        
    }
}
