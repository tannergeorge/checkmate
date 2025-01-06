//
//  GroupsView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct GroupsView: View {
    var body: some View {
        VStack {
            ListIcon(name: "Groceries", emoji: "🥑", color: .green, tasks: 4)
            Text("Groups")
                .font(.largeTitle)
                .bold()
                .padding()
            Text("Everything in Checkmate relies on groups, which store relevant tasks, notes, and calendar events. You can customize them however you'd like!")
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding()
                .background(.quinary)
                .cornerRadius(16)
                .padding()
        }
    }
}

#Preview {
    GroupsView()
}
