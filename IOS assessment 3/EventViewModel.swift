//
//  EventViewModel.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 9/5/2025.
//

import Foundation
import SwiftUI
import MapKit


class EventViewModel: ObservableObject {
    @Published var allEvents: [Event] = []
    @Published var selectedCategory: String? = nil

    init() {
        // 可替换为从 Core Data 读取
        loadSampleEvents()
    }

    func loadSampleEvents() {
        allEvents = [
            Event(
                title: "BBQ Festival",
                organizer: "Helena",
                address: "1 BBQ Street, Sydney",
                summary: "A local BBQ event with live music and food trucks.",
                date: Date(),
                imageName: "bbq",
                category: "Food",
                maxPeople: 20,
                interestedCount: 10,
                location: CLLocationCoordinate2D(latitude: -33.8731, longitude: 151.2065)
            )
        ]
    }
}
