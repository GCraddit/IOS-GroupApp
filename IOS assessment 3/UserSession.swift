//
//  UserSession.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//
import Foundation
import CoreLocation
import MapKit


class UserSession: ObservableObject {
    @Published var currentUser: User?

    var allUsers: [User] = [
        // Merchant users
        User(
            name: "Helena",
            email: "helena@example.com",
            password: "123456",
            avatarImage: ImageAssets.avatars[0], // for example use profiles 1
            isMerchant: true,
            preferredLocation: CLLocationCoordinate2D(latitude: -33.884, longitude: 151.204),
            createdEvents: [],
            favoriteEvents: [],
            notifications: []
        ),

        // Ordinary user A (near UTS)
        User(
            name: "Leo",
            email: "leo@example.com",
            password: "654321",
            avatarImage: ImageAssets.avatars[1],
            isMerchant: false,
            preferredLocation: CLLocationCoordinate2D(latitude: -33.8855, longitude: 151.2022),
            createdEvents: [],
            favoriteEvents: [],
            notifications: []
        ),

        //  Ordinary user B (stay away from CBD and will not receive notifications)
        User(
            name: "Ava",
            email: "ava@example.com",
            password: "111222",
            avatarImage: ImageAssets.avatars[2],
            isMerchant: false,
            preferredLocation: CLLocationCoordinate2D(latitude: -33.76, longitude: 151.01),
            createdEvents: [],
            favoriteEvents: [],
            notifications: []
        )
    ]


    func login(email: String, password: String) -> Bool {
        if let found = allUsers.first(where: { $0.email == email && $0.password == password }) {
            currentUser = found
            return true
        }
        return false
    }

    func logout() {
        currentUser = nil
    }
    
    func sendNotificationToNearbyUsers(for event: Event) {
        let radiusKm: Double = 3.0

        guard let current = currentUser else { return }

        for i in 0..<allUsers.count {
            var user = allUsers[i]

            // Exclude yourself and other merchants
            if user.id != current.id, !user.isMerchant {
                let distanceKm = distance(from: event.location, to: user.preferredLocation)
                if distanceKm <= radiusKm {
                    let notification = NotificationItem(
                        type: .comment,
                        sender: current.name,
                        message: "posted nearby event: \(event.title)",
                        date: Date(),
                        relatedEvent: event
                    )
                    allUsers[i].notifications.append(notification)

                    // If it happens to be the current user (for testing), also update the copy
                    if current.id == user.id {
                        currentUser = allUsers[i]
                    }
                }
            }
        }
    }

    func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        let loc1 = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let loc2 = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return loc1.distance(from: loc2) / 1000
    }

}

