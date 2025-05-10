//
//  UserSession.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//
import Foundation

class UserSession: ObservableObject {
    @Published var currentUser: User?

    // 可选：你也可以存一个模拟用户数据库
    var allUsers: [User] = [
        User(
            name: "Helena",
            email: "helena@example.com",
            password: "123456",
            avatarImage: "person1",
            createdEvents: [],
            favoriteEvents: []
        ),
        User(
            name: "Leo",
            email: "leo@example.com",
            password: "654321",
            avatarImage: "person2",
            createdEvents: [],
            favoriteEvents: []
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
}

