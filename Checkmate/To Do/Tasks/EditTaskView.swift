//
//  EditTaskView.swift
//  Checkmate
//
//  Created by Tanner George on 10/18/24.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var task: Task
    @ObservedObject var viewModel: ItemViewModel
    
    @State var newCompleted: Bool = false
    @State var newName: String = ""
    @State var newNotes: String = ""
    
    @State private var showingAlert = false
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        impactMed.impactOccurred()
                        newCompleted.toggle()
                    } label: {
                        Image(systemName: newCompleted ? "checkmark.circle": "circle")
                            .font(.system(size: 24))
                    }
                    
                    TextField("Task name", text: $newName)
                        .bold()
                        .font(.system(size: 28))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                }
                .padding([.leading, .trailing, .bottom])
                
                ZStack {
                    RoundedRectangle(cornerRadius: (25/80) * 45)
                        .strokeBorder(.quaternary, style: StrokeStyle(lineWidth: 1.0))
                    TextField("Add notes", text: $newNotes, axis: .vertical)
                        .font(.system(size: 18))
                        .lineLimit(5, reservesSpace: true)
                        .padding()
                }
                .padding([.leading, .trailing])
                
                /*
                TextField("Add notes", text: $newNotes, axis: .vertical)
                    .font(.system(size: 18))
                    .lineLimit(5, reservesSpace: true)
                    .overlay(RoundedRectangle(cornerRadius: (25/80) * 45)
                        .strokeBorder(.quaternary, style: StrokeStyle(lineWidth: 1.0)))
                    .padding([.leading, .trailing])
                 */
                
                Spacer()
                    
                Button {
                    if (newName == "") {
                        withAnimation {
                            showingAlert = true
                        }
                    } else {
                        save()
                    }
                } label: {
                    TextButton(text: "Save", textSize: 20, height: 50, cornerRadius: 15.625,
                               backgroundColor: colorScheme == .light ? .black : .white,
                               textColor: colorScheme == .light ? .white : .black)
                }
                .padding()
            }
            .toolbar {
                Button {
                    withAnimation {
                        delete(task: task)
                    }
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            newCompleted = task.completed
            newName = task.name!
            newNotes = task.notes!
        }
        .presentationDetents([.height(325)])
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("You're missing some info"),
                message: Text("Name your task using the text field."),
                dismissButton: .default(Text("Close"))
            )
            
        }
    }
    
    private func save() {
        withAnimation {
            task.completed = newCompleted
            task.name = newName
            task.notes = newNotes
            try? moc.save()
            viewModel.isSheetPresented = false
        }
    }
    
    private func delete(task: Task) {
        withAnimation {
            viewModel.isSheetPresented = false
            moc.delete(task)
            try? moc.save()
        }
    }
    
}

#Preview {
    //EditTaskView()
}
