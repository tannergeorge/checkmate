//
//  TaskIcon.swift
//  Checkmate
//
//  Created by Tanner George on 10/18/24.
//

import SwiftUI

struct TaskIcon: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var task: Task
    var color: Color
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        
        if (task.name != nil) {
            ZStack {
                RoundedRectangle(cornerRadius: (25/80) * 60)
                    .stroke(color, lineWidth: 2)
                    .frame(height: 60)
                    .opacity(0.8)
                HStack {
                    Button {
                        impactMed.impactOccurred()
                        toggleComplete()
                    } label: {
                        Image(systemName: task.completed ? "checkmark.circle": "circle")
                            .font(.system(size: 20))
                    }
                    Text(task.name!)
                        .font(.system(size: 24))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                }
                .padding()
            }
            .padding([.leading, .trailing, .top])
            .opacity(task.completed ? 0.5 : 1)
        }
    }
    
    private func toggleComplete() {
        withAnimation {
            task.completed.toggle()
            try? moc.save()
        }
    }
    
}

#Preview {
    //TaskIcon(name: "test", color: .red, completed: false)
}
