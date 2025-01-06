//
//  Editing.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct EditingView: View {
    var body: some View {
        VStack {
            Text("🎨")
                .font(.system(size: 90))
            Text("Editing")
                .font(.largeTitle)
                .bold()
                .padding([.leading, .trailing, .bottom])
            Text("To edit a task, note, or event, simply tap on it. For groups, simply press and hold on the group icon.")
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
    EditingView()
}
