//
//  NewTaskView.swift
//  Checkmate
//
//  Created by Tanner George on 10/17/24.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @State private var name: String = ""
    @State private var showingAlert = false
    var listID: UUID
    
    @Binding var showingPopover: Bool
    
    var body: some View {
        VStack {
            TextField("Task name", text: $name)
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .frame(height: 45)
                .overlay(RoundedRectangle(cornerRadius: (25/80) * 45)
                    .strokeBorder(.quaternary, style: StrokeStyle(lineWidth: 1.0)))
                .padding(.top, 35)
                .padding([.leading, .trailing, .bottom])
            
            Spacer()
            
            Button {
                if (name == "") {
                    withAnimation {
                        showingAlert = true
                    }
                } else {
                    createTask(name: name, id: UUID(), listID: listID, notes: "", completed: false, timestamp: Date.now)
                }
            } label: {
                TextButton(text: "Create", textSize: 20, height: 50, cornerRadius: 15.625,
                           backgroundColor: (colorScheme == .light) ? .black: .white,
                           textColor: (colorScheme == .light) ? .white: .black)
            }
            .padding([.leading, .trailing, .bottom])
            
        }
        .presentationDetents([.height(150)])
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("You're missing some info"),
                message: Text("Name your task using the text field."),
                dismissButton: .default(Text("Close"))
            )
            
        }
    }
    
    private func createTask(name: String, id: UUID, listID: UUID, notes: String, completed: Bool, timestamp: Date) {
        let newTask = Task(context: moc)
        newTask.name = name
        newTask.id = id
        newTask.listID = listID
        newTask.notes = notes
        newTask.completed = completed
        newTask.timestamp = timestamp
        
        withAnimation {
            try? moc.save()
            showingPopover = false
        }
    }
}

#Preview {
    //NewTaskView()
}
