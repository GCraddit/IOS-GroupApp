//
//  MainTabView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }

            ReleaseEventView()
                .tabItem {
                    Label("Post", systemImage: "plus.circle")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            DashboardView()
                .tabItem {
                    Label("Me", systemImage: "person")
                }
        }
    }
}
#Preview {
    MainTabView()
        .environmentObject(EventViewModel())
        .environmentObject(UserSession())
}

