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
    @Published var favoriteEvents: [Event] = []
    @Published var lastAddedEvent: Event? = nil


    init() {
        loadSampleEvents()
    }

    func loadSampleEvents() {
        let sample = Event(
            title: "BBQ Festival",
            organizer: "Helena",
            address: "BBQ Street, Sydney",
            summary: "A tasty BBQ with live music and chill vibes.",
            date: Date(),
            imageName: "bbq",
            category: "Food",
            maxPeople: 20,
            interestedCount: 10,
            location: CLLocationCoordinate2D(latitude: -33.8731, longitude: 151.2065)
        )

        allEvents = [sample]
        favoriteEvents = [sample] // ✅ 设为已收藏
    }

    // ✅ 添加活动
    func addEvent(title: String,
                  organizer: String,
                  address: String,
                  summary: String,
                  imageName: String,
                  category: String,
                  maxPeople: Int,
                  location: CLLocationCoordinate2D) {
        let newEvent = Event(
            title: title,
            organizer: organizer,
            address: address,
            summary: summary,
            date: Date(),
            imageName: imageName,
            category: category,
            maxPeople: maxPeople,
            interestedCount: 0,
            location: location
        )

        allEvents.append(newEvent)
        self.lastAddedEvent = newEvent

    }
    
    func isFavorite(_ event: Event) -> Bool {
        return favoriteEvents.contains(where: { $0.id == event.id })
    }

    func toggleFavorite(_ event: Event) {
        if isFavorite(event) {
            favoriteEvents.removeAll { $0.id == event.id }
        } else {
            favoriteEvents.append(event)
        }
    }
    
    func incrementInterest(for event: Event) {
        if let index = allEvents.firstIndex(where: { $0.id == event.id }) {
            if allEvents[index].interestedCount < allEvents[index].maxPeople {
                allEvents[index].interestedCount += 1
            }
        }
    }


}
