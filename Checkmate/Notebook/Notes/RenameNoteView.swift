//
//  RenameNoteView.swift
//  Checkmate
//
//  Created by Tanner George on 12/28/24.
//

import SwiftUI

struct RenameNoteView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @State private var name: String = ""
    @State private var showingAlert = false
    var note: Note
    
    @Binding var showingPopover: Bool

    var body: some View {
        VStack {
            TextField("Note name", text: $name)
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
                    withAnimation {
                        note.name = name
                        try? moc.save()
                        showingPopover = false
                    }
                }
            } label: {
                TextButton(text: "Save", textSize: 20, height: 50, cornerRadius: 15.625,
                           backgroundColor: (colorScheme == .light) ? .black: .white,
                           textColor: (colorScheme == .light) ? .white: .black)
            }
            .padding([.leading, .trailing, .bottom])
            
        }
        .presentationDetents([.height(150)])
        .onAppear {
            name = note.name!
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("You're missing some info"),
                message: Text("Rename your note using the text field."),
                dismissButton: .default(Text("Close"))
            )
        }
    }
}

#Preview {
    //RenameNoteView()
}
