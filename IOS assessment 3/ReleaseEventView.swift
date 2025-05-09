//
//  ReleaseEventView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI
import CoreLocation


struct ReleaseEventView: View {
    @EnvironmentObject var eventVM: EventViewModel

    // 用户输入状态
    @State private var title = ""
    @State private var address = ""
    @State private var maxPeople = ""
    @State private var summary = ""
    @State private var category = "Food"
    @State private var imageName = "bbq" // 默认图

    let categoryOptions = ["Food", "Music", "Art", "Market", "Sports"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Event Name")) {
                    TextField("Add event name", text: $title)
                }

                Section(header: Text("Address")) {
                    TextField("Add address", text: $address)
                }

                Section(header: Text("Maximum number of people")) {
                    TextField("e.g. 10", text: $maxPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Select Image")) {
                    // 模拟图片选择：使用 Picker 或随机
                    Picker("Image", selection: $imageName) {
                        Text("BBQ").tag("bbq")
                        Text("Mahjong").tag("mahjong")
                    }
                }

                Section(header: Text("Select Category")) {
                    Picker("Category", selection: $category) {
                        ForEach(categoryOptions, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                }

                Section(header: Text("Summary")) {
                    TextEditor(text: $summary)
                        .frame(minHeight: 80)
                }

                Button("Post") {
                    let newEvent = Event(
                        title: title,
                        organizer: "You",
                        address: address,
                        summary: summary,
                        date: Date(),
                        imageName: imageName,
                        category: category,
                        maxPeople: Int(maxPeople) ?? 10,
                        interestedCount: 0,
                        location: CLLocationCoordinate2D(latitude: -33.0, longitude: 151.0)
                    )

                    eventVM.addEvent(
                        title: title,
                        organizer: "You",
                        address: address,
                        summary: summary,
                        imageName: imageName,
                        category: category,
                        maxPeople: Int(maxPeople) ?? 10,
                        location: CLLocationCoordinate2D(latitude: -33.0, longitude: 151.0)
                    )

                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("New Event")
        }
    }
}
#Preview {
    ReleaseEventView()
        .environmentObject(EventViewModel())
}
