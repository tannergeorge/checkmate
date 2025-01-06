//
//  AboutView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Checkmate was created by Tanner George.")
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Button {
                    if let url = URL(string: "https://www.termsfeed.com/live/058d2af7-3af0-47b8-b594-eacb6022933c") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    TextButton(text: "View privacy policy", textSize: 20, height: 50, cornerRadius: 15.625,
                               backgroundColor: .black,
                               textColor: .white)
                    .padding()
                }
            }
            .navigationTitle("About")
        }
        .presentationDetents([.height(250)])
    }
}

#Preview {
    AboutView()
}
