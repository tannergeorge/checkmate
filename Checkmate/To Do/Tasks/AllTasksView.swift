//
//  AllTasksView.swift
//  Checkmate
//
//  Created by Tanner George on 10/14/24.
//

import SwiftUI

struct AllTasksView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    Text("All tasks")
                    Spacer()
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    AllTasksView()
}
