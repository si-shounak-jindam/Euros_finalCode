//
//  GroupsViewDemo.swift
//  EURO
//
//  Created by Shounak Jindam on 11/06/24.
//
import SwiftUI

struct GroupsMainView: View {
    @ObservedObject var viewModel: GroupsViewModel
    @ObservedObject var ScoreSheetViewModel: ScoreSheetViewModel
    
    var body: some View {
        let groups = viewModel.groupTeamsDictNew
        VStack(spacing:0){
            
            NavigationBar(viewModel: viewModel)
                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 80)
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
                                GroupsHeaderView(index: i, viewModel: viewModel)
                                GroupsListView(index: i,viewModel: viewModel)
                                GroupsFooterView(index: i,viewModel: viewModel, 
                                                 scoreSheetViewModel: ScoreSheetViewModel)
                            }
                            .cornerRadius(15)
                        }
                        .padding(.horizontal,15)
                    }
                    ThirdPlaceHeaderView(viewModel: viewModel)
                }
                .padding(.vertical,20)
            }
            .padding(.all, UIDevice.current.userInterfaceIdiom == .pad ? 30 : 0)
            .background(Color.scrollBg)
            .ignoresSafeArea(.all,edges: .vertical)
        }
    }
}

struct GroupsMainView_Previews_New: PreviewProvider {
    static var previews: some View {
        GroupsMainView(viewModel: GroupsViewModel(), ScoreSheetViewModel: ScoreSheetViewModel())
    }
}

