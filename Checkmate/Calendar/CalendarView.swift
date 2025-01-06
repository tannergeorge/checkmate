//
//  CalendarView.swift
//  Checkmate
//
//  Created by Tanner George on 10/17/24.
//

import SwiftUI
import CoreData

struct CalendarView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "startDate", ascending: true)]) var events: FetchedResults<Event>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var lists: FetchedResults<List>
    @StateObject private var viewModel = ItemViewModel()
   
    //Environment
    @Environment(\.colorScheme) var colorScheme
    
    //Popover and haptic
    @State private var currDate = Date.now
    @State private var showingDatePicker = false
    @State private var showingAddPopover = false
    @State private var showingEditPopover = false
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
                        ForEach(events) { e in
                            if (areDatesSameDay(e.startDate!, currDate)) {
                                if (getList(event: e) != nil) {
                                    Button {
                                        withAnimation {
                                            viewModel.selectedEvent = e
                                            showingEditPopover = true
                                        }
                                    } label: {
                                        EventIcon(list: getList(event: e)!, event: e)
                                    }
                                }
                            }
                        }
                    }
                }
                .blur(radius: showingDatePicker ? 10 : 0)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            impactMed.impactOccurred()
                            showingAddPopover = true
                        } label: {
                            PlusButton(color: colorScheme == .light ? .black : .white)
                        }
                    }
                    .padding()
                }
                .blur(radius: showingDatePicker ? 10 : 0)
                .padding()
                
                if (showingDatePicker) {
                    ZStack {
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation {
                                    showingDatePicker = false
                                }
                            }
                        DatePicker("", selection: $currDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(maxHeight: 400)
                            .labelsHidden()
                            .padding()
                    }
                }
            }
            .navigationTitle(formatToMonthDay(from: currDate))
            .toolbar {
                Button {
                    withAnimation {
                        showingDatePicker.toggle()
                    }
                } label: {
                    Image(systemName: "arrow.left.arrow.right")
                }
            }
        }
        .popover(isPresented: $showingAddPopover) {
            NewEventView(showingPopover: $showingAddPopover, day: currDate)
        }
        .sheet(isPresented: $showingEditPopover) {
            if let event = viewModel.selectedEvent {
                EditEventView(event: event, showingPopover: $showingEditPopover)
            }
        }
    }
    
    func areDatesSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func formatToMonthDay(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.string(from: date)
    }
    
    func getList(event: Event) -> List? {
        for list in lists {
            if (list.id == event.listID) {
                return list
            }
        }
        
        return nil
    }
}

#Preview {
    CalendarView()
}
