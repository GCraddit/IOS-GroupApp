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

    // 可选：你也可以存一个模拟用户数据库
    var allUsers: [User] = [
        // ✅ 商户用户
        User(
            name: "Helena",
            email: "helena@example.com",
            password: "123456",
            avatarImage: ImageAssets.avatars[0], // 例如使用 profile1,
            isMerchant: true,
            preferredLocation: CLLocationCoordinate2D(latitude: -33.884, longitude: 151.204),
            createdEvents: [],
            favoriteEvents: [],
            notifications: []
        ),

        // ✅ 普通用户 A（在 UTS 附近）
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

        // ✅ 普通用户 B（远离 CBD，不会收到通知）
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

            // 排除自己、排除其他商户
            if user.id != current.id, !user.isMerchant {
                let distanceKm = distance(from: event.location, to: user.preferredLocation)
                if distanceKm <= radiusKm {
                    let notification = NotificationItem(
                        type: .comment, // 或你自定义的 .event
                        sender: current.name,
                        message: "posted nearby event: \(event.title)",
                        date: Date(),
                        relatedEvent: event
                    )
                    allUsers[i].notifications.append(notification)

                    // 如果刚好是当前用户本人（测试用），也更新副本
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
        return loc1.distance(from: loc2) / 1000 // 转换为公里
    }

}

