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
    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)

    @State private var title = ""
    @State private var address = ""
    @State private var maxPeople = ""
    @State private var summary = ""
    @State private var category = "Food"
    @State private var imageName = "bbq"

    let categoryOptions = ["Food", "Music", "Art", "Market", "Sports"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Event Name").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextField("Add event name", text: $title)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Address").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextField("Add address", text: $address)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Maximum number of people").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextField("e.g. 10", text: $maxPeople)
                        .keyboardType(.numberPad)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Select Image").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    Picker("Image", selection: $imageName) {
                        Text("BBQ").tag("bbq")
                        Text("Mahjong").tag("mahjong")
                    }
                    .pickerStyle(.menu)
                }

                Section(header: Text("Select Category").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    Picker("Category", selection: $category) {
                        ForEach(categoryOptions, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section(header: Text("Summary").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextEditor(text: $summary)
                        .frame(minHeight: 80)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }
                Section(header: Text("Location").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    MapSelectorView(selectedCoordinate: $selectedCoordinate)
                        .frame(height: 250)

                    Text("Lat: \(selectedCoordinate.latitude), Lon: \(selectedCoordinate.longitude)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }


                Button("Post") {
                    eventVM.addEvent(
                        title: title,
                        organizer: "You",
                        address: address,
                        summary: summary,
                        imageName: imageName,
                        category: category,
                        maxPeople: Int(maxPeople) ?? 10,
                        location: selectedCoordinate

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
