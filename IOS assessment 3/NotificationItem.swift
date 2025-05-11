//
//  NotificationItem.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import Foundation
import SwiftUI


struct NotificationItem: Identifiable {
    let id = UUID()
    let type: NotificationType
    let sender: String
    let message: String
    let date: Date

    // Optional associated Event (used to jump to the detail page)
    let relatedEvent: Event?
}


enum NotificationType {
    case comment, like, follow

    var iconName: String {
        switch self {
        case .comment: return "bubble.left.fill"
        case .like: return "heart.fill"
        case .follow: return "person.fill.badge.plus"
        }
    }

    var iconColor: Color {
        switch self {
        case .comment: return .blue
        case .like: return .red
        case .follow: return .green
        }
    }
}
