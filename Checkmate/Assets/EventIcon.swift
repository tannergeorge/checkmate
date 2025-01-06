//
//  EventIcon.swift
//  Checkmate
//
//  Created by Tanner George on 12/29/24.
//

import SwiftUI

struct EventIcon: View {
    let dateFormatter = DateFormatter()
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var list: List
    @ObservedObject var event: Event
    
    let colorMap: [String: Color] = [
        "red": .red,
        "orange": .orange,
        "green": .green,
        "blue": .blue,
        "purple": .purple,
        "pink": .pink
    ]

    var body: some View {
        if (list.name != nil) {
            ZStack {
                RoundedRectangle(cornerRadius: (25/80) * 60)
                    .stroke(colorMap[list.color!]!, lineWidth: 2)
                    .frame(height: 60)
                    .opacity(0.8)
                HStack {
                    Text(list.icon! + "  " + (event.title ?? ""))
                        .font(.system(size: 24))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Text(formatTime(from: event.startDate ?? Date.now))
                        .font(.system(size: 24))
                        .foregroundStyle(.tertiary)
                }
                .padding()
            }
            .padding([.leading, .trailing, .top])
        }
    }
    
    func formatTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    //EventIcon()
}
