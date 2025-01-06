//
//  TextButton.swift
//  Checkmate
//
//  Created by Tanner George on 10/16/24.
//

import SwiftUI

struct TextButton: View {
    var text: String
    var textSize: CGFloat
    var height: CGFloat
    var cornerRadius: Double
    var backgroundColor: Color
    var textColor: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(backgroundColor)
                .frame(height: height)
                .cornerRadius(cornerRadius)
            Text(text)
                .font(.system(size: textSize))
                .foregroundStyle(textColor)
        }

    }
}

#Preview {
    //TextButton()
}
