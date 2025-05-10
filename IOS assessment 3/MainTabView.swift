//
//  MainTabView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//
import SwiftUI

struct MainTabView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(1)

            ReleaseEventView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Post", systemImage: "plus.circle")
                }
                .tag(2)

            FavoritesView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .tag(3)

            DashboardView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Me", systemImage: "person")
                }
                .tag(4)
        }
    }
}
#Preview {
    MainTabView(selectedTab: .constant(0))
        .environmentObject(EventViewModel())
        .environmentObject(UserSession())
}

