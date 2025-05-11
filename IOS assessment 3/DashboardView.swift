//
//  DashboardView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var eventVM: EventViewModel
    @EnvironmentObject var userSession: UserSession
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTab: Int
    
    @State private var tabFilter = "My Events"
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @State private var showLoginSheet = false
    

    let tabs = ["My Events", "Favorites", "Following"]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // User header
                HStack(spacing: 16) {
                    Image(userSession.currentUser?.avatarImage ?? "defaultAvatar")
                        .resizable()
                        .frame(width: 60, height: 60)

                    VStack(alignment: .leading) {
                        Text("Helena")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("City Explorer")
                            .font(.subheadline)
                            .foregroundColor(AppStyle.secondaryText)
                    }
                    Spacer()
                }
                .padding(.horizontal, AppStyle.cardPadding)
                
                NavigationLink(destination: EditProfileView()) {
                    Text("Edit Profile")
                        .font(.subheadline)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                        .padding(.horizontal, AppStyle.cardPadding)
                }


                // Tab Picker
                Picker("Select", selection: $tabFilter
) {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, AppStyle.cardPadding)
                .padding(.top)

                // Card List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredEvents, id: \.id) { event in
                            EventCardView(event: event)
                        }
                    }
                    .padding(.horizontal, AppStyle.cardPadding)
                }

                Spacer()

                // Exit Button
                Button("Sign Out") {
                    print("Signing out...")
                    userSession.currentUser = nil
                    isLoggedIn = false
                    selectedTab = 0 // ✅Force return to home page
                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.bordered)
                .foregroundColor(.red)
            }
            .navigationTitle("My Dashboard")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ActivityFeedView()) {
                        Image(systemName: "bell.fill")
                    }
                }
            }

        }
        .onAppear {
            if userSession.currentUser == nil {
                showLoginSheet = true
            }
        }
        .sheet(isPresented: $showLoginSheet, onDismiss: {
            if userSession.currentUser == nil {
                selectedTab = 0 // ✅ Automatically jump back to the home page tab
            }
        }) {
            SignInView()
                .environmentObject(userSession)
                .interactiveDismissDisabled(false)
        }
    }
    

    // Data filtering logic
    var filteredEvents: [Event] {
        switch tabFilter {
        case "Favorites":
            return eventVM.favoriteEvents
        case "Following":
            return Array(eventVM.allEvents.dropFirst(1))
        default:
            return eventVM.allEvents
        }
    }

}

#Preview {
    DashboardView(selectedTab: .constant(0))
        .environmentObject(EventViewModel())
        .environmentObject(UserSession())
}
