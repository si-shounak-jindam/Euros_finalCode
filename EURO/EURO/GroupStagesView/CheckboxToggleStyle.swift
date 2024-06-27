//
//  CheckboxToggleStyle.swift
//  EURO
//
//  Created by Shounak Jindam on 27/06/24.
//

import SwiftUI

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

