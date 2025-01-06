//
//  NoteIcon.swift
//  Checkmate
//
//  Created by Tanner George on 12/27/24.
//

import SwiftUI
import Foundation

struct NoteIcon: View {
    let dateFormatter = DateFormatter()
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var note: Note
    var color: Color
    
    var body: some View {
        if (note.name != nil) {
            ZStack {
                RoundedRectangle(cornerRadius: (25/80) * 60)
                    .stroke(color, lineWidth: 2)
                    .frame(height: 60)
                    .opacity(0.8)
                HStack {
                    Text(note.name!)
                        .font(.system(size: 24))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Text(formatDate(d: note.timestamp!))
                        .font(.system(size: 24))
                        .foregroundStyle(.tertiary)
                }
                .padding()
            }
            .padding([.leading, .trailing, .top])
        }
    }
    
    private func formatDate(d: Date) -> String {
        dateFormatter.dateFormat = "M/d"
        return dateFormatter.string(from: d)
    }
}

#Preview {
    //NoteIcon()
}
