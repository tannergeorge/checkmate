//
//  EditNoteView.swift
//  Checkmate
//
//  Created by Tanner George on 12/27/24.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var note: Note
    @ObservedObject var viewModel: ItemViewModel
    
    @State var newNotes: String = ""
    
    @State var showingRenamePopover = false
    
    var listID = UUID()
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Tap to add text", text: $newNotes, axis: .vertical)
                    .font(.system(size: 18))
                    .lineLimit(10, reservesSpace: true)
                    .padding()
                Spacer()
                Button {
                    saveNotes(text: newNotes)
                } label: {
                    TextButton(text: "Save", textSize: 20, height: 50, cornerRadius: 15.625,
                               backgroundColor: colorScheme == .light ? .black : .white,
                               textColor: colorScheme == .light ? .white : .black)
                }
                .padding()
            }
            .navigationTitle(note.name ?? "")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        showingRenamePopover = true
                    } label: {
                        Image(systemName: "character.textbox")
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                    }
                    
                    Button {
                        deleteNote()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }

            }
        }
        .sheet(isPresented: $showingRenamePopover) {
            RenameNoteView(note: note, showingPopover: $showingRenamePopover)
        }
        .onAppear {
            newNotes = note.text ?? ""
        }
    }
    
    private func saveNotes(text: String) {
        withAnimation {
            note.text = text
            try? moc.save()
            viewModel.isSheetPresented = false
        }
    }
    
    private func deleteNote() {
        withAnimation {
            viewModel.isSheetPresented = false
            moc.delete(note)
            try? moc.save()
        }
    }
}

#Preview {
    //EditNoteView()
}
