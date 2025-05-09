//
//  EventCardView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//
import SwiftUI
import CoreLocation

struct EventCardView: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 活动图片
            Image(event.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 180)
                .cornerRadius(12)
                .clipped()

            // 活动标题
            Text(event.title)
                .font(.headline)

            // 时间 & 地点
            HStack {
                Label(event.date.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                Spacer()
                Label(event.address, systemImage: "mappin.and.ellipse")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)

            // 类型 + 参与人数
            HStack {
                Text(event.category)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)

                Spacer()

                Label("\(event.interestedCount) going", systemImage: "star.fill")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    EventCardView(event: Event(
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
    ))
    .padding()
}

