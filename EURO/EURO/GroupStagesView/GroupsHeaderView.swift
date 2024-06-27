//
//  GroupHeaderView.swift
//  EURO
//
//  Created by Shounak Jindam on 27/06/24.
//

import SwiftUI

struct GroupsHeaderView: View {
    var index: Int
    @State private var isEnabled: [Bool] = [true, true, true, true]
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        let groupKey = viewModel.groupTeamsDictNew[index].name
        let teams = viewModel.groupTeamsDictNew[index].teams
        
        let allFalse = self.isEnabled.allSatisfy { $0 == false }
        VStack{
            HStack {
                VStack(alignment: .leading) {
                    Text("Group \(groupKey)")
                        .font(.system(size: 27))
                    if allFalse{
                        Text("Drag teams to reorder")
                            .font(.system(size: 15))
                    }
                }
                .foregroundColor(.white)
                .padding(.leading, 20)
                Spacer()
            }
            HStack(spacing: 45){
                ForEach(teams.indices, id: \.self) { i in
                    if !allFalse{
                        Button(action: {
                            viewModel.addTeams(team: teams[i],
                                               groupKey: groupKey)
                            self.isEnabled[i].toggle()
                            withAnimation {
                                viewModel.progressViewCounter += 1/43
                            }
                        }) {
                            if isEnabled[i]{
                                VStack{
                                    Image(teams[i].teamFlag)
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                    
                                    Text(teams[i].teamName)
                                        .foregroundColor(.white)
                                }
                            }
                            else{
                                
                                VStack{
                                    Circle()
                                        .foregroundColor(Color.gray.opacity(0.7))
                                        .frame(width: 35, height: 35)
                                    Text(" ")
                                        .foregroundColor(.white)
                                }
                            }
                            
                        }
                        .disabled(!self.isEnabled[i])
                    }
                }
            }
        }
        .padding(.vertical, 20)
        .background(
            HStack{
                allFalse ? Color.headingColour : Color.blue
                Spacer().frame(width: 0)
                allFalse ? AnyView(Image(.headerBG).resizable().scaledToFit()): AnyView(Color.blue)
            }
            
        )
    }
}
