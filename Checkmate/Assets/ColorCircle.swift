//
//  ColorCircle.swift
//  Checkmate
//
//  Created by Tanner George on 10/16/24.
//

import SwiftUI

struct ColorCircle: View {
    var c: Color
    var currColor: Color
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if (currColor == c) {
                Circle()
                    .stroke(colorScheme == .light ? .black : .white, lineWidth: 1.75)
                    .frame(height: 35)
            } else {
                Circle()
                    .stroke(.quaternary)
                    .frame(height: 35)
            }

            
            Circle()
                .frame(height: 30)
                .foregroundStyle(c)
                .opacity(0.8)
                .padding([.leading, .trailing], 9)
        }
    }
}

#Preview {
    ColorCircle(c: .red, currColor: .red)
}
