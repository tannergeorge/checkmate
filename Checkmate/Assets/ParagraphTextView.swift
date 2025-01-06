//
//  ParagraphTextView.swift
//  Checkmate
//
//  Created by Tanner George on 10/18/24.
//

import SwiftUI

struct ParagraphTextView: View {
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Placeholder text
            if text == "" {
                Text("Enter text here...")
                    .foregroundColor(.gray)
                    .padding(.top, 8) // Adjust for better placement
                    .padding(.leading, 5)
            }
            
            // Text editor
            TextEditor(text: $text)
                .padding(4) // Padding inside the text editor
                .background(Color.clear) // Clear background to show the border
        }
    }
}

#Preview {
    //ParagraphTextView()
}
