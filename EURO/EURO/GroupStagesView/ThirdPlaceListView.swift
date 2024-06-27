//
//  ThirdPlaceListView.swift
//  EURO
//
//  Created by Shounak Jindam on 27/06/24.
//

import SwiftUI

struct ThirdPlaceListView: View {
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
                            withAnimation {
                                viewModel.progressViewCounter += 1/43
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
            .CFSDKcornerRadius(20, corners: [.topLeft, .topRight])
        }
        .fullScreenCover(isPresented: $viewModel.showKnockoutBracket, content: {
            KnockoutPOC(viewModel: viewModel)
        })
        .edgesIgnoringSafeArea(.bottom)
    }
}

