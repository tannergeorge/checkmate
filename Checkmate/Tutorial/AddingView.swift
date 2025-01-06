//
//  AddingView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct AddingView: View {
    var body: some View {
        VStack {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 90))
            Text("Adding groups")
                .font(.largeTitle)
                .bold()
                .padding()
            Text("Add a group by using the black plus button on either the Tasks or Notes screens. Tap the smile to choose a fun emoji!")
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
    AddingView()
}
