//
//  EditView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Text("✍️")
                .font(.system(size: 90))
            Text("Adding info")
                .font(.largeTitle)
                .bold()
                .padding([.leading, .trailing, .bottom])
            Text("Add a task or note to a group by tapping on its icon. To add a calendar event, simply tap the black plus button.")
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
    InfoView()
}
