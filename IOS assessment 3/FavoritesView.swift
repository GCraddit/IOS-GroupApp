//
//  FavoritesView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var eventVM: EventViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                if eventVM.favoriteEvents.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray.opacity(0.6))

                        Text("No favorites yet.")
                            .font(.headline)
                            .foregroundColor(AppStyle.secondaryText)
                    }
                    .padding(.top, 100)
                } else {
                    VStack(spacing: 16) {
                        ForEach(eventVM.favoriteEvents) { event in
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EventCardView(event: event)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, AppStyle.cardPadding)
                }
            }
            .scrollIndicators(.hidden)
            .background(Color(.systemBackground))
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(EventViewModel())
}
