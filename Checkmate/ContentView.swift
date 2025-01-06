//
//  ContentView.swift
//  Checkmate
//
//  Created by Tanner George on 10/14/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("completedTutorial") var completedTutorial: Bool = false
    @State var displayingTutorial = true
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    
    @State private var splashing = true
    
    var body: some View {
        if splashing {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                        withAnimation {
                            splashing = false
                        }
                    }
                }
        } else {
            if (completedTutorial == false && displayingTutorial == true) {
                TutorialView(displayingTutorial: $displayingTutorial)
            } else {
                TabView {
                    AllListsView()
                        .tabItem {
                            Label("Tasks", systemImage: "checklist")
                        }
                    
                    NotebooksView()
                        .tabItem {
                            Label("Notes", systemImage: "book.pages")
                        }
                    
                    CalendarView()
                        .tabItem {
                            Label("Calendar", systemImage: "calendar")
                        }
                }
                .opacity(completedTutorial ? 1 : 0)
                .tint(colorScheme == .light ? .black : .white)
            }
        }
    }
}

#Preview {
    //ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
