//
//  User.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 9/5/2025.
//

import Foundation
import CoreLocation
import MapKit

struct User: Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var password: String
    var avatarImage: String
    var isMerchant: Bool = false
    var preferredLocation: CLLocationCoordinate2D
    var createdEvents: [Event]
    var favoriteEvents: [Event]
    var notifications: [NotificationItem] = []
}

