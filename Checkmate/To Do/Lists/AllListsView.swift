//
//  AllListView.swift
//  Checkmate
//
//  Created by Tanner George on 10/14/24.
//

import SwiftUI

struct AllListsView: View {
    //Core data
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var lists: FetchedResults<List>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var allTasks: FetchedResults<Task>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var allNotes: FetchedResults<Note>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "startDate", ascending: true)]) var allEvents: FetchedResults<Event>
    
    @StateObject private var viewModel = ItemViewModel()
   
    //Environment
    @Environment(\.colorScheme) var colorScheme
    
    //Popover and haptic
    @State private var selectedList: List?
    @State private var showingPopover = false
    @State private var showingEditPopover = false
    @State private var showingAboutPopover = false
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    //Colors
    let colorMap: [String: Color] = [
        "red": .red,
        "orange": .orange,
        "green": .green,
        "blue": .blue,
        "purple": .purple,
        "pink": .pink
    ]
        
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        //Loops through all lists
                        ForEach(lists, id: \.self) { l in
                            //Displays list name in corresponding color
                            //Then links to a detail view with all relevant info passed
                            NavigationLink {
                                ListView(listName: l.name ?? "No name", listEmoji: l.icon ?? "H", listColor: colorMap[l.color!] ?? .blue, listID: l.id!)
                            } label: {
                                ListIcon(name: l.name!, emoji: l.icon!, color: colorMap[l.color!] ?? .blue, tasks: getTasks(listID: l.id!))
                            }
                            .contextMenu {
                                Button {
                                    viewModel.selectedList = l
                                    showingEditPopover = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button {
                                    withAnimation {
                                        deleteMatches(l: l)
                                        moc.delete(l)
                                        try? moc.save()
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                        .foregroundStyle(.red)
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
                            showingPopover = true
                        } label: {
                            PlusButton(color: colorScheme == .light ? .black : .white)
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .navigationTitle("Tasks")
            .tint(colorScheme == .light ? .black : .white)
            .toolbar {
                Button {
                    showingAboutPopover = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .popover(isPresented: $showingPopover) {
            NewListView(showingPopover: $showingPopover)
        }
        .sheet(isPresented: $showingEditPopover) {
            if let list = viewModel.selectedList {
                EditListView(list: list, showingPopover: $showingEditPopover)
            }
        }
        .popover(isPresented: $showingAboutPopover) {
            AboutView()
        }
    }
    
    private func getTasks(listID: UUID) -> Int {
        var count = 0
        
        for task in allTasks {
            if (task.listID == listID) {
                count += 1
            }
        }
        
        return count
    }
    
    private func deleteMatches(l: List) {
        for task in allTasks {
            if (task.listID == l.id) {
                moc.delete(task)
            }
        }
        
        for note in allNotes {
            if (note.listID == l.id) {
                moc.delete(note)
            }
        }
        
        for event in allEvents {
            if (event.listID == l.id) {
                moc.delete(event)
            }
        }
    }
    
}

#Preview {
    AllListsView()
}
