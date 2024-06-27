//
//  NavigationBar.swift
//  EURO
//
//  Created by Shounak Jindam on 26/06/24.
//

import SwiftUI

struct NavigationBar: View {
    @ObservedObject var viewModel: GroupsViewModel
    
    var body: some View {
        ZStack {
            Image("headerBG")
                .resizable()
                .scaledToFill()
                .clipped()
            HStack {
                VStack {
                    Text("\(viewModel.navigationGroupTitle)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(.top, 60)
                }
                Spacer()
            }
            .padding(.top, 80)
            .padding(.leading, 20)
        }
    }
}
