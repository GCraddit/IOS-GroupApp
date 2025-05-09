//
//  Event.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 9/5/2025.
//

import Foundation
import CoreLocation
import MapKit

struct Event: Identifiable {
    var id = UUID()
    var title: String
    var organizer: String
    var address: String
    var summary: String
    var date: Date
    var imageName: String
    var category: String
    var maxPeople: Int
    var interestedCount: Int
    var location: CLLocationCoordinate2D
}

