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
    @EnvironmentObject var userSession: UserSession
    @State private var showLoginSheet = false
    @State private var hasRegistered = false


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // the front page
                Image(event.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 220)
                    .cornerRadius(AppStyle.cardCornerRadius)
                    .clipped()

                // faverite button
                HStack {
                    Spacer()
                    Button {
                        if userSession.currentUser == nil {
                            showLoginSheet = true
                            return
                        }

                        eventVM.toggleFavorite(event)

                        if let userIndex = userSession.allUsers.firstIndex(where: { $0.id == userSession.currentUser?.id }) {
                            if let favIndex = userSession.allUsers[userIndex].favoriteEvents.firstIndex(where: { $0.id == event.id }) {
                                userSession.allUsers[userIndex].favoriteEvents.remove(at: favIndex)
                            } else {
                                userSession.allUsers[userIndex].favoriteEvents.append(event)
                            }

                            userSession.currentUser = userSession.allUsers[userIndex]
                        }
                    } label: {
                        Image(systemName: eventVM.isFavorite(event) ? "heart.fill" : "heart")
                            .foregroundColor(eventVM.isFavorite(event) ? .red : .gray)
                            .font(.title2)
                    }


                }
                .padding(.trailing)

                // info
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

                // button details
                Button {
                    if userSession.currentUser == nil {
                        showLoginSheet = true
                    } else if !hasRegistered && event.interestedCount < event.maxPeople {
                        hasRegistered = true
                        eventVM.incrementInterest(for: event)
                    }
                } label: {
                    Text(hasRegistered ? "Registered" : "Select")
                }
                .disabled(hasRegistered || event.interestedCount >= event.maxPeople)
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.borderedProminent)
                .foregroundColor(hasRegistered ? .gray : .white)
            }
            .padding()
        }
        .navigationTitle("Event Detail Page")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showLoginSheet) {
            SignInView()
                .environmentObject(userSession)
        }
    }

    // mark for some small component
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
    let event = Event(
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
    )

    let viewModel = EventViewModel()
    viewModel.allEvents.append(event)

    let session = UserSession()
    session.currentUser = User(
        name: "PreviewUser",
        email: "preview@example.com",
        password: "123",
        avatarImage: "profile1",
        isMerchant: false,
        preferredLocation: CLLocationCoordinate2D(latitude: -33.0, longitude: 151.0),
        createdEvents: [],
        favoriteEvents: [],
        notifications: []
    )

    return NavigationStack {
        EventDetailView(event: event)
            .environmentObject(viewModel)
            .environmentObject(session)
    }
}

