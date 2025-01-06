//
//  TutorialView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct TutorialView: View {
    @Binding var displayingTutorial: Bool
    
    var body: some View {
        TabView {
            WelcomeView()
            GroupsView()
            AddingView()
            InfoView()
            EditingView()
            FinishView(displayingTutorial: $displayingTutorial)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

#Preview {
    //TutorialView(displayingTutorial: $true)
}
