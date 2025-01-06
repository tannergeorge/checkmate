//
//  EditEventView.swift
//  Checkmate
//
//  Created by Tanner George on 12/31/24.
//

import SwiftUI

struct EditEventView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: true)]) var lists: FetchedResults<List>
    
    @State private var showingAlert = false
    
    var event: Event
    @Binding var showingPopover: Bool
    var day: Date? = nil
    
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
        NavigationView {
            VStack {
                HStack {
                    TextField("Event title", text: $eventTitle)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
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
                            save()
                            showingPopover = false
                        }
                    }
                } label: {
                    TextButton(text: "Save", textSize: 20, height: 50, cornerRadius: 15.625,
                               backgroundColor: (colorScheme == .light) ? .black: .white,
                               textColor: (colorScheme == .light) ? .white: .black)
                }
                .padding()
            }
            .toolbar {
                Button {
                    withAnimation {
                        showingPopover = false
                        moc.delete(event)
                        try? moc.save()
                    }
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .presentationDetents([.height(575)])
        .onAppear {
            eventTitle = event.title!
            selectedList = matchList(listID: event.listID!)!.name!
            selectedStartTime = event.startDate!
            selectedEndTime = event.endDate!
            eventDetails = event.notes!
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("You're missing some info"),
                message: Text("Name your event using the text field and select a calendar using the picker menu."),
                dismissButton: .default(Text("Close"))
            )
        }
    }
    
    func save() {
        event.title = eventTitle
        event.listID = matchList()!.id
        event.startDate = combine(dayFrom: event.startDate!, timeFrom: selectedStartTime)
        event.endDate = combine(dayFrom: event.endDate!, timeFrom: selectedEndTime)
        event.notes = eventDetails
        
        try? moc.save()
    }
    
    func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short // Example: "12:00 PM"
        return formatter.string(from: date)
    }
    
    func matchList() -> List? {
        for list in lists {
            if (list.name == selectedList) {
                return list
            }
        }
        return nil
    }
    
    func matchList(listID: UUID) -> List? {
        for list in lists {
            if (list.id == listID) {
                return list
            }
        }
        return nil
    }
    
    func combine(dayFrom dateWithDay: Date, timeFrom dateWithTime: Date) -> Date? {
        let calendar = Calendar.current
        
        // Extract day components
        let dayComponents = calendar.dateComponents([.year, .month, .day], from: dateWithDay)
        
        // Extract time components
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: dateWithTime)
        
        // Combine the components
        var combinedComponents = DateComponents()
        combinedComponents.year = dayComponents.year
        combinedComponents.month = dayComponents.month
        combinedComponents.day = dayComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        combinedComponents.second = timeComponents.second
        
        // Create and return the combined Date
        return calendar.date(from: combinedComponents)
    }
    
}

#Preview {
    //EditEventView()
}
