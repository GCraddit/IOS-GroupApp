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
                    .cornerRadius(AppStyle.cardCornerRadius)
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
                    infoRow(label: "EVENT NAME", value: event.title)
                    infoRow(label: "Organizer", value: event.organizer, color: .blue)
                    infoRow(label: "ADDRESS", value: event.address)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("SUMMARY")
                            .font(.caption)
                            .foregroundColor(AppStyle.secondaryText)
                        Text(event.summary)
                    }

                    infoRow(label: "Number of participants (registered)", value: "\(event.interestedCount)")
                }
                .padding(.horizontal)

                // 按钮
                Button("Select") {
                    // 报名逻辑待实现
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

    // MARK: - 复用小组件
    func infoRow(label: String, value: String, color: Color = .primary) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundColor(AppStyle.secondaryText)
            Spacer()
            Text(value)
                .foregroundColor(color)
        }
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
