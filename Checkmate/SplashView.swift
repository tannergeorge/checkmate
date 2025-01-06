//
//  SplashView.swift
//  Checkmate
//
//  Created by Tanner George on 10/19/24.
//

import SwiftUI

struct SplashView: View {
    let currentHour = Calendar.current.component(.hour, from: Date())
    var body: some View {
        VStack {
            Text(getEmoji())
                .font(.system(size: 70))
                .padding(5)
            Text(getMessage())
                .font(.largeTitle)
                .bold()
        }
    }
    
    private func getEmoji() -> String {
        if currentHour >= 6 && currentHour < 12 {
            return "🌝"
        } else if currentHour >= 12 && currentHour < 18 {
            return "🌞"
        } else {
            return "🌚"
        }
    }
    
    private func getMessage() -> String {
        if currentHour >= 6 && currentHour < 12 {
            return "Good morning"
        } else if currentHour >= 12 && currentHour < 18 {
            return "Good afternoon"
        } else {
            return "Good evening"
        }
    }
}

#Preview {
    SplashView()
}
