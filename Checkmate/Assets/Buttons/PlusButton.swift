//
//  PlusButton.swift
//  Checkmate
//
//  Created by Tanner George on 10/16/24.
//

import SwiftUI

struct PlusButton: View {
    var color: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Circle()
                .frame(height: 60)
                .tint(colorScheme == .light ? .white: .black)
            Circle()
                .frame(height: 60)
                .tint(color)
                .opacity((color == .white || color == .black) ? 1.0 : 0.8)
            Image(systemName: "plus")
                .font(.system(size: 28))
                .tint(colorScheme == .light ? .white: .black)
        }
    }
}

#Preview {
    PlusButton(color: .red)
}
