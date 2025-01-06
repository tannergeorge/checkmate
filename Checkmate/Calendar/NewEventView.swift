//
//  NewEventView.swift
//  Checkmate
//
//  Created by Tanner George on 12/29/24.
//

import SwiftUI

struct NewEventView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var lists: FetchedResults<List>
    
    @Binding var showingPopover: Bool
    var day: Date
    
    @State private var showingAlert = false
    
    @State private var eventTitle: String = ""
    @State private var selectedList: String? = nil
    @State private var startPickerIsVisible = false
    @State private var endPickerIsVisible = false
    @State private var eventDetails: String = ""
    
    @State private var selectedStartTime: Date = {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 12
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    @State private var selectedEndTime: Date = {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 13
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Event title", text: $eventTitle)
                    .font(.system(size: 36))
                    .bold()
                Spacer()
            }
            .padding(.top, 40)
            .padding([.leading, .trailing, .bottom])
            
            ScrollView {
                VStack {
                    HStack {
                        Text("Calendar")
                            .font(.system(size: 18))
                            .bold()
                        Spacer()
                        Picker("Select", selection: $selectedList) {
                            Text("Select").tag(String?.none) // Initial empty selection
                            ForEach(lists, id: \.self) { list in
                                Text(list.icon! + " " + list.name!).tag(list.name! as String?)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .font(.system(size: 18))
                    }
                    .padding()
                    
                    HStack {
                        Text("Start time")
                            .font(.system(size: 18))
                            .bold()
                        Spacer()
                        
                        Button {
                            withAnimation {
                                startPickerIsVisible.toggle()
                            }
                        } label: {
                            Text(formattedTime(from: selectedStartTime))
                                .font(.system(size: 18))
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(16)
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                    
                    if (startPickerIsVisible) {
                        DatePicker(
                                "",
                                selection: $selectedStartTime,
                                displayedComponents: .hourAndMinute // Restrict to time selection
                        )
                        .labelsHidden() // Hides the default label
                        .datePickerStyle(WheelDatePickerStyle()) // Use wheel style for time picker
                    }
                    
                    HStack {
                        Text("End time")
                            .font(.system(size: 18))
                            .bold()
                        Spacer()
                        
                        Button {
                            withAnimation {
                                endPickerIsVisible.toggle()
                            }
                        } label: {
                            Text(formattedTime(from: selectedEndTime))
                                .font(.system(size: 18))
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(16)
                        }
                    }
                    .padding([.leading, .trailing, .bottom])
                    
                    if (endPickerIsVisible) {
                        DatePicker(
                                "",
                                selection: $selectedEndTime,
                                displayedComponents: .hourAndMinute // Restrict to time selection
                        )
                        .labelsHidden() // Hides the default label
                        .datePickerStyle(WheelDatePickerStyle()) // Use wheel style for time picker
                    }
                    
                    HStack {
                        Text("Details")
                            .font(.system(size: 18))
                            .bold()
                            .padding([.leading, .trailing])
                        Spacer()
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: (25/80) * 45)
                            .strokeBorder(.quaternary, style: StrokeStyle(lineWidth: 1.0))
                        TextField("Add details", text: $eventDetails, axis: .vertical)
                            .font(.system(size: 18))
                            .lineLimit(3, reservesSpace: true)
                            .padding()
                    }
                    .padding([.leading, .trailing, .bottom])
                }
            }
            
            Spacer()
            Button {
                if (eventTitle == "" || selectedList == nil || selectedList == "") {
                    showingAlert = true
                } else {
                    withAnimation {
                        createEvent()
                        showingPopover = false
                    }
                }
            } label: {
                TextButton(text: "Create", textSize: 20, height: 50, cornerRadius: 15.625,
                           backgroundColor: (colorScheme == .light) ? .black: .white,
                           textColor: (colorScheme == .light) ? .white: .black)
            }
            .padding()
        }
        .presentationDetents([.height(575)])
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("You're missing some info"),
                message: Text("Name your event using the text field and select a calendar using the picker menu."),
                dismissButton: .default(Text("Close"))
            )
        }
    }
    
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short // Example: "12:00 PM"
        return formatter.string(from: date)
    }
    
    func createEvent() {
        let newEvent = Event(context: moc)
        newEvent.title = eventTitle
        newEvent.id = UUID()
        newEvent.listID = matchList()!.id
        newEvent.startDate = combine(date: day, with: selectedStartTime)
        newEvent.endDate = combine(date: day, with: selectedEndTime)
        newEvent.notes = eventDetails
        
        try? moc.save()
    }
    
    func matchList() -> List? {
        for list in lists {
            if (list.name == selectedList) {
                return list
            }
        }
        return nil
    }
    
    func combine(date: Date, with time: Date) -> Date {
        let calendar = Calendar.current
        
        // Extract the day, month, and year from the current date
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        // Extract the hour and minute from the selected time
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        // Merge both components
        var combinedComponents = dateComponents
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        // Create the new Date
        return calendar.date(from: combinedComponents) ?? date
    }
}

#Preview {
    //NewEventView()
}
