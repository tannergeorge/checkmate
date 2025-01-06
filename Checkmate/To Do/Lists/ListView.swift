//
//  ListView.swift
//  Checkmate
//
//  Created by Tanner George on 10/14/24.
//

import SwiftUI

class ItemViewModel: ObservableObject {
    @Published var selectedList: List? = nil
    @Published var selectedTask: Task? = nil
    @Published var selectedNote: Note? = nil
    @Published var selectedEvent: Event? = nil
    @Published var isSheetPresented: Bool = false
}


struct ListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "completed", ascending: true),  NSSortDescriptor(key: "timestamp", ascending: true)]) var allTasks: FetchedResults<Task>
    
    var listName: String
    var listEmoji: String
    var listColor: Color
    var listID: UUID
    
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    @State var showingAddPopover = false
    @State var showingEditPopover = false
    
    @State var thisTask: Task?
    
    @StateObject private var viewModel = ItemViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(allTasks, id: \.self) { task in
                        if (task.listID == listID) {
                            Button {
                                viewModel.selectedTask = task
                                viewModel.isSheetPresented = true
                            } label: {
                                TaskIcon(task: task, color: listColor)
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
            if let task = viewModel.selectedTask {
                EditTaskView(task: task, viewModel: viewModel)
            }
        }
        .popover(isPresented: $showingAddPopover) {
            NewTaskView(listID: listID, showingPopover: $showingAddPopover)
        }
    }
}

#Preview {
    //ListView(listName: "Test", listEmoji: "🔥", color: .red)
}
