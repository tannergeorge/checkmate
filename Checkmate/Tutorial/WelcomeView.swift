//
//  WelcomeView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("👋")
                .font(.system(size: 90))
                .padding()
            Text("Hey!")
                .font(.largeTitle)
                .bold()
                .padding()
            Text("Welcome to Checkmate. Let's learn a little about the app. Swipe left to start!")
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
    WelcomeView()
}
