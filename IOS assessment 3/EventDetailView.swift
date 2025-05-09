//
//  EventDetailView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI
import MapKit

struct EventDetailView: View {
    let event: Event
    @EnvironmentObject var eventVM: EventViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 封面图
                Image(event.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 220)
                    .cornerRadius(12)
                    .clipped()
                // 收藏按钮
                HStack {
                    Spacer()
                    Button {
                        eventVM.toggleFavorite(event)
                    } label: {
                        Image(systemName: eventVM.isFavorite(event) ? "heart.fill" : "heart")
                            .foregroundColor(eventVM.isFavorite(event) ? .red : .gray)
                            .font(.title2)
                    }
                }
                .padding(.trailing)

                // 信息项
                VStack(spacing: 12) {
                    HStack {
                        Text("EVENT NAME")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(event.title)
                    }

                    HStack {
                        Text("Organizer")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(event.organizer)
                            .foregroundColor(.blue)
                    }

                    HStack {
                        Text("ADDRESS")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(event.address)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("SUMMARY")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(event.summary)
                    }

                    HStack {
                        Text("Number of participants (registered)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(event.interestedCount)")
                    }
                }
                .padding(.horizontal)
                

                // 按钮
                Button("Select") {
                    // 可添加报名逻辑
                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Event Detail Page")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    NavigationStack {
        EventDetailView(event: Event(
            title: "Mahjong",
            organizer: "Helena",
            address: "1, ABC, Sydney, 2000",
            summary: "It is a mahjong game",
            date: Date(),
            imageName: "mahjong",
            category: "Game",
            maxPeople: 8,
            interestedCount: 2,
            location: CLLocationCoordinate2D(latitude: -33.0, longitude: 151.0)
        ))
        .environmentObject(EventViewModel())
    }
}
