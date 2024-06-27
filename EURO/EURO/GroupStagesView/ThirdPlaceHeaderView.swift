//
//  ThirdPlaceHeaderView.swift
//  EURO
//
//  Created by Shounak Jindam on 27/06/24.
//

import SwiftUI

struct ThirdPlaceHeaderView: View{ 
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
            
            ThirdPlaceListView(viewModel: viewModel)
        }
        
        .cornerRadius(10)
        .padding(15)
        
    }
    
}

