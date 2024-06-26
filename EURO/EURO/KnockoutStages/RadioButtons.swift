//
//  RadioButtons.swift
//  EURO
//
//  Created by Shounak Jindam on 21/06/24.
//

import SwiftUI

struct RadioButton: View {
    @ObservedObject var viewModel: GroupsViewModel
    @Binding var selectedOption: String
    var teamName: String
    var teamFlag: String

    var body: some View {
        HStack {
            Image(teamFlag)
                .resizable()
                .frame(width: 30, height: 30)
                .background(Color.gray.opacity(0.5))
                .clipShape(Circle())
            Text(teamName)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: selectedOption == teamName ? selectedOption.isEmpty ? "circle" : "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.cfsdkWhite)
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
        .background(selectedOption == teamName ? selectedOption.isEmpty ? Color.black.opacity(0.01) : Color.blue.opacity(0.6) : Color.black.opacity(0.01))
        .onTapGesture {
            toggleSelection()
        }
        .frame(height: 40)
    }
    
    private func toggleSelection() {
        if selectedOption == teamName {
            selectedOption = ""
        } else {
            selectedOption = teamName
        }
    }
}
  

