//
//  ActivityFeedView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct ActivityFeedView: View {
    let notifications: [NotificationItem] = [
        NotificationItem(type: .like, sender: "Alice", message: "liked your event BBQ Festival", date: Date()),
        NotificationItem(type: .comment, sender: "Bob", message: "commented: Looks fun!", date: Date().addingTimeInterval(-3600)),
        NotificationItem(type: .follow, sender: "Charlie", message: "started following you", date: Date().addingTimeInterval(-7200))
    ]

    var body: some View {
        NavigationStack {
            List(notifications) { note in
                HStack(spacing: 12) {
                    Image(systemName: note.type.iconName)
                        .foregroundColor(note.type.iconColor)
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(note.sender) \(note.message)")
                            .font(.subheadline)

                        Text(note.date.formatted(date: .abbreviated, time: .shortened))
                            .font(AppStyle.captionFont)
                            .foregroundColor(AppStyle.secondaryText)
                    }
                }
                .padding(.vertical, 6)
            }
            .scrollContentBackground(.hidden)
            .background(Color(.systemBackground))
            .navigationTitle("Activity Feed")
        }
    }
}

#Preview {
    ActivityFeedView()
}
