//
//  NewListView.swift
//  Checkmate
//
//  Created by Tanner George on 10/15/24.
//

import SwiftUI
import MCEmojiPicker

struct NewListView: View {
    //Core data
    @Environment(\.managedObjectContext) var moc
    //Environment
    @Environment(\.colorScheme) var colorScheme
    //Emoji keyboard
    @State private var showingEmojis: Bool = false
    //Colors
    let colors: [Color] = [.red, .orange, .green, .blue, .purple, .pink]
    let colorMap: [Color: String] = [
        .red: "red",
        .orange: "orange",
        .green: "green",
        .blue: "blue",
        .purple: "purple",
        .pink: "pink"
    ]
    
    @State private var currColor: Color = .blue
    
    //CoreData
    @State private var name: String = ""
    @State private var color: String = "blue"
    @State private var emoji: String = ""
    
    //Popover
    @Binding var showingPopover: Bool
    
    //Alert
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                //Emoji circle
                Button {
                    showingEmojis = true
                } label: {
                    EmojiCircle(emoji: emoji, currColor: currColor)
                }
                .padding()
                .emojiPicker(isPresented: $showingEmojis, selectedEmoji: $emoji, arrowDirection: .down)
                
                HStack {
                    ForEach(colors, id: \.self) { c in
                        Button {
                            withAnimation {
                                currColor = c
                            }
                            color = colorMap[c]!
                        } label: {
                            ColorCircle(c: c, currColor: currColor)
                        }
                    }
                }
                .padding([.leading, .trailing])
                
                TextField("Group name", text: $name)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .frame(height: 45)
                    .overlay(RoundedRectangle(cornerRadius: (25/80) * 45)
                        .strokeBorder(.quaternary, style: StrokeStyle(lineWidth: 1.0)))
                    .padding()
                
                Spacer()
                
                Button {
                    if (name == "" || emoji == "") {
                        showingAlert = true
                    } else {
                        createList(name: name, emoji: emoji, color: color, id: UUID(), timestamp: Date.now)
                    }
                } label: {
                    TextButton(text: "Create", textSize: 20, height: 50, cornerRadius: 15.625,
                               backgroundColor: (colorScheme == .light) ? .black: .white,
                               textColor: (colorScheme == .light) ? .white: .black)
                }
                .padding([.leading, .trailing, .bottom])
            }
            .padding([.top], 25)
        }
        .presentationDetents([.height(300)])
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("You're missing some info"),
                message: Text("Name your list using the text field and add an emoji by tapping the smile."),
                dismissButton: .default(Text("Close"))
            )
            
        }
    }
    
    private func createList(name: String, emoji: String, color: String, id: UUID, timestamp: Date) {
        let newList = List(context: moc)
        newList.name = name
        newList.icon = emoji
        newList.color = color
        newList.id = UUID()
        newList.timestamp = Date.now
        
        withAnimation {
            try? moc.save()
            showingPopover = false
        }
    }
}

#Preview {
    //NewListView()
}
