//
//  EmojiCircle.swift
//  Checkmate
//
//  Created by Tanner George on 10/16/24.
//

import SwiftUI

struct EmojiCircle: View {
    var emoji: String
    var currColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .frame(height: 80)
                .foregroundColor(currColor)
                .opacity(0.25)
            Image(systemName: "face.dashed")
                .font(.system(size: (50/70) * 80))
                .foregroundColor(currColor)
                .opacity(emoji == "" ? 1 : 0)
            Text(emoji)
                .font(.system(size: (50/70) * 80))
                .opacity(emoji == "" ? 0 : 1)
        }
    }
}

#Preview {
    EmojiCircle(emoji: "", currColor: .blue)
}
