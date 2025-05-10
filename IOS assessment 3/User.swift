//
//  User.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 9/5/2025.
//

import Foundation

struct User: Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var password: String
    var avatarImage: String
    var createdEvents: [Event]
    var favoriteEvents: [Event]
}
