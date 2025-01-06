//
//  FinishView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct FinishView: View {
    @AppStorage("completedTutorial") var completedTutorial: Bool = false
    @Binding var displayingTutorial: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Text("🏎️")
                .font(.system(size: 90))
            Text("You're all set!")
                .font(.largeTitle)
                .bold()
                .padding([.leading, .trailing, .bottom])
            Spacer()
            Button {
                withAnimation {
                    displayingTutorial = false
                }
                completedTutorial = true
            } label: {
                TextButton(text: "Let's go!", textSize: 20, height: 50, cornerRadius: 15.625,
                           backgroundColor: .black,
                           textColor: .white)
            }
            .padding([.leading, .trailing, .top])
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    //FinishView()
}
