//
//  ListIconView.swift
//  Checkmate
//
//  Created by Tanner George on 10/14/24.
//

import SwiftUI

struct ListIcon: View {
    var name: String
    var emoji: String
    var color: Color
    var tasks: Int
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 80)
                .foregroundColor(color)
                .opacity(0.7)
                .cornerRadius(25)
                .padding([.leading, .trailing])
            HStack {
                Text(emoji)
                    .font(.system(size: 40))
                    .padding([.leading])
                    .padding([.trailing], 4)
                Text(name)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .bold()
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                ZStack {
                    Circle()
                        .frame(height: 60)
                        .padding([.leading, .trailing])
                        .foregroundColor(colorScheme == .light ? .white : .black)
                    Text(String(tasks))
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(color)
                        .opacity(0.7)
                }
            }
            .padding([.leading, .trailing])
        }
    }
}

#Preview {
    ListIcon(name: "Test", emoji: "🔥", color: .red, tasks: 3)
}
