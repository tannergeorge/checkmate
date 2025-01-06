//
//  NoteookView.swift
//  Checkmate
//
//  Created by Tanner George on 12/27/24.
//

import SwiftUI

struct NotebookView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)]) var allNotes: FetchedResults<Note>
    
    var listName: String
    var listEmoji: String
    var listColor: Color
    var listID: UUID
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    @State var showingAddPopover = false
    @State var showingEditPopover = false
    
    @State var thisNote: Note?
    
    @StateObject private var viewModel = ItemViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(allNotes, id: \.self) { note in
                        if (note.listID == listID) {
                            Button {
                                viewModel.selectedNote = note
                                viewModel.isSheetPresented = true
                            } label: {
                                NoteIcon(note: note, color: listColor)
                            }
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        impactMed.impactOccurred()
                        showingAddPopover = true
                    } label: {
                        PlusButton(color: listColor)
                    }
                }
                .padding()
            }
            .padding()
            
        }
        .navigationTitle(listEmoji + " " + listName)
        .sheet(isPresented: $viewModel.isSheetPresented) {
            if let note = viewModel.selectedNote {
                EditNoteView(note: note, viewModel: viewModel)
            }
        }
        .popover(isPresented: $showingAddPopover) {
            NewNoteView(listID: listID, showingPopover: $showingAddPopover)
        }
    }
}

#Preview {
    //NotebookView()
}
