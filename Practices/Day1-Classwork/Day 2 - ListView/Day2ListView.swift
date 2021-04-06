//
//  Day2ListView.swift
//  Day1-Classwork
//
//  Created by Samuel Folledo on 4/6/21.
//


import SwiftUI

struct WeekSection: Identifiable {
    var id: String { name }
    var name: String
    var days: [WeekDay]
}

struct WeekDay: Identifiable {
    var id: String { name }
    var name: String
}


struct Day2ListView: View {
    
//    let days = [WeekDay(name: "Friday"), WeekDay(name: "Saturday"), WeekDay(name: "Sunday")]
    let weekSections = [
                        WeekSection(name: "Work days", days:[WeekDay(name: "Monday"), WeekDay(name: "Tuesday"), WeekDay(name: "Wednesday")]),
                        WeekSection(name: "Weekend days", days:[WeekDay(name: "Friday"), WeekDay(name: "Saturday"), WeekDay(name: "Sunday")])
    ]

    
    var body: some View {
        NavigationView{
              List {
                ForEach(weekSections){ dayName in
                    Text(dayName.name)
                }
              }
              .navigationTitle("Weekend")
            }
    }
}

struct Day2ListView_Previews: PreviewProvider {
    static var previews: some View {
        Day2ListView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("User Preview iPhone 8")
        
//        ContentView()
//                    .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
//                    .previewDisplayName("Client Preview on iPhone 12 Pro Max")
    }
}
