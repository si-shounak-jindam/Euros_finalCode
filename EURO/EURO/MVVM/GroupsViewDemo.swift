//
//  GroupsViewDemo.swift
//  EURO
//
//  Created by Shounak Jindam on 11/06/24.
//
import SwiftUI

struct GroupsViewDemo: View {
    @ObservedObject var viewModel: GroupsViewModel
    @ObservedObject var ScoreSheetViewModel: ScoreSheetViewModel
    
    var body: some View {
        let groups = viewModel.groupTeamsDictNew
        VStack(spacing:0){
            // Navigation Bar
            NavigationBar(viewModel: viewModel)
                .frame(height: 80)
                .ignoresSafeArea(.all,edges: .top)
                .onAppear {
                    viewModel.updateNavigationGroupTitle("Group Stages")
                }
            VStack(spacing:5){
                SponsorView()
                ProgressBar(progress: $viewModel.progressViewCounter)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(groups.indices) { i in
                            VStack(spacing: 0){
                                GroupHeaderDemo(index: i, viewModel: viewModel)
                                GroupListDemo(index: i,viewModel: viewModel)
                                GroupFooterDemo(index: i,viewModel: viewModel, scoreSheetViewModel: ScoreSheetViewModel)
                            }
                            .cornerRadius(15)
                        }
                        .padding(.horizontal,15)
                    }
                    PredictorUIDemo(viewModel: viewModel)
                }
                .padding(.vertical,20)
            }
            .background(Color.scrollBg)
            .ignoresSafeArea(.all,edges: .vertical)
        }
    }
}

// MARK: - Header
struct GroupHeaderDemo: View {
    
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
                                viewModel.progressViewCounter += 1/35
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

// MARK: - ListView
struct GroupListDemo: View {
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



// MARK: - Footer
struct GroupFooterDemo: View {
    var index: Int
    @ObservedObject var viewModel: GroupsViewModel
    @StateObject var scoreSheetViewModel: ScoreSheetViewModel
    
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
        .fullScreenCover(isPresented: $viewModel.showBottomSheet, content: {
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
            Spacer()
            VStack {
                HStack {
                    Text("Most popular Group prediction")
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
                            scoreSheetViewModel.showScoreSheet.toggle()
                        }, label: {
                            Text("See how to score points")
                                .foregroundColor(.white
                                )
                        })
                        .padding()
                        Spacer()
                    }
                    .sheet(isPresented: $scoreSheetViewModel.showScoreSheet, content: {
                        ScorePointSheet()
                            .clearModalBackground()
                    })
                }
            }
            .background(FANTASYTheme.getColor(named: .groupSheetBlue))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - PredictorUI

struct PredictorUIDemo: View{
    
    
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        VStack(spacing:0){
            VStack(spacing:0){
                HStack{
                    Spacer()
                    VStack(alignment: .leading,spacing: 10){
                        Text("Predict the four best third - placed teams")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                        Text("The four with the most points will progress to the knockout stage.")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
            .padding([.top,.bottom])
            .background(Color.blue)
            
            PredictorListUI(viewModel: viewModel)
        }
        
        .cornerRadius(10)
        .padding(15)
        
    }
    
}

// MARK: - PredictorUILists

struct PredictorListUI: View {
    @ObservedObject var viewModel: GroupsViewModel
    var rowHeight: CGFloat? = 55
    
    var body: some View {
        let items = viewModel.predictorNew
        let maxSelectionsReached = viewModel.checkedItemsCount >= 4
        VStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { i in
                VStack(spacing: 0) {
                    HStack(spacing: 15) {
                        Toggle(isOn: $viewModel.predictorNew[i].isChecked) {
                        }
                        .onChange(of: viewModel.predictorNew[i].isChecked) { newValue in
                            // Your action here
                            withAnimation {
                                viewModel.progressViewCounter += 1/35
                            }
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.7), lineWidth: 0.7)
                        )
                        .frame(width: 30)
                        .toggleStyle(CheckboxToggleStyle())
                        .disabled(items[i].flag == "" || (maxSelectionsReached && !items[i].isChecked))
                        
                        HStack(spacing: 15) {
                            Image("\(items[i].flag)")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .cornerRadius(25)
                                .background(items[i].flag == "" ? Color.gray.opacity(0.5) : Color.clear)
                                .cornerRadius(25)
                                .overlay(
                                    items[i].flag != "" ? RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2) : nil
                                )
                            
                            Text("\(items[i].teamName)").foregroundColor(.white)
                            Spacer()
                            Text("Group \(items[i].name)").foregroundColor(.white).opacity(0.5)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    if items[i].name != "F" {
                        Divider().frame(height: 0.5).background(Color.gray).opacity(0.3)
                    }
                }
                .frame(height: rowHeight)
                .background(viewModel.predictorNew[i].isChecked ? Color(hex: 0x101d6b) : Color(hex: 0x101d6b).opacity(0.4))
            }
        }
        .background(
            FANTASYTheme.getColor(named: .groupSheetBlue)
        )
        .fullScreenCover(isPresented: Binding(
            get: { maxSelectionsReached },
            set: { _ in }
        ), content: {
            VStack {
                Spacer()
                knockoutStageBottomSheet
            }
            .clearModalBackground()
        })
    }
    
    var knockoutStageBottomSheet: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Text("Good Work!")
                        .foregroundColor(.white)
                    Text("Now Let's move on to the Knockout Stage!")
                        .foregroundColor(.white)
                    Button(action: {
                        viewModel.showKnockoutBracket.toggle()
                    }, label: {
                        Text("Continue")
                            .foregroundColor(.black)
                            .padding(.horizontal, 100)
                            .padding(.vertical, 15)
                            .background(
                                FANTASYTheme.getColor(named: .CFSDKAccent1)
                            )
                            .CFSDKcornerRadius(10, corners: .allCorners)
                    })
                }
                .padding(10)
                Spacer()
            }
            .background(FANTASYTheme.getColor(named: .groupSheetBlue))
        }
        .fullScreenCover(isPresented: $viewModel.showKnockoutBracket, content: {
            KnockoutPOC(viewModel: viewModel)
        })
        .edgesIgnoringSafeArea(.bottom)
    }
}


// MARK: - CheckBox Toggle struct
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "")
                .resizable()
                .foregroundColor(configuration.isOn ? .white : .white.opacity(0.5))
                .frame(width: 25, height: 25)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct GroupsView_Previews_New: PreviewProvider {
    static var previews: some View {
        GroupsViewDemo(viewModel: GroupsViewModel(), ScoreSheetViewModel: ScoreSheetViewModel())
    }
}

