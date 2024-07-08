//
//  ScorePointSheet.swift
//  EURO
//
//  Created by Shounak Jindam on 13/06/24.
//

import SwiftUI

struct ScorePointSheet: View {
    @StateObject private var scoreSheetViewModel = ScoreSheetViewModel()
    @ObservedObject private var viewModel = GroupsViewModel()
    
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack {
                HStack {
                    Text("How to Score Points")
                        .font(.title3.bold())
                        .foregroundColor(.cfsdkWhite)
                        .padding([.top, .leading], 20)
                    Spacer()
                    Button(action: {
                        scoreSheetViewModel.showScoreSheet = false
                    }, label: {
                        Image(systemName: "xmark")
                            .accentColor(.cfsdkWhite)
                            .padding([.top, .trailing], 10)
                    })
                    
                }
                Divider()
                    .background (
                        Color.white.opacity(0.5)
                    )
                ForEach(viewModel.dummyData?.data ?? [], id: \.id) { data in
                    HStack {
                        Text(data.employeeName ?? "")
                            .font(.title3.bold())
                            .foregroundColor(.cfsdkWhite)
                            .padding([.top, .leading], 10)
                        Spacer()
//                        Text(scoreSheetViewModel.scoreSheetDetail[index].points)
//                            .font(.title3.bold())
//                            .foregroundColor(scoreSheetViewModel.scoreSheetDetail[index].points == "0 pts" ? .cfsdkAccentError: .cfsdkWhite)
//                            .padding([.top, .trailing], 10)
                    }
                    HStack{
                        Text(data.employeeName ?? "")
                            .font(.subheadline)
                            .foregroundColor(.cfsdkWhite).opacity(0.7)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                    }
                    .padding(.leading,10)
                    Divider()
                        .background(Color.white.opacity(0.5))
                }
                
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Text("Read full article")
                            .foregroundColor(.cfsdkAccent1)
                    })
                    .padding()
                    Spacer()
                }
            }
            .background (
                FANTASYTheme.getColor(named: .CFSDKPrimary3)
            )
            .CFSDKcornerRadius(20, corners: [.topLeft, .topRight])
            
            
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ScorePointSheet()
}
