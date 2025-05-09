//
//  DashboardView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var eventVM: EventViewModel
    @State private var selectedTab = "My Events"
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true

    let tabs = ["My Events", "Favorites", "Following"]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 用户头部
                HStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading) {
                        Text("Helena")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("City Explorer")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                }
                .padding(.horizontal)

                // Tab Picker
                Picker("Select", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // 卡片列表
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredEvents(), id: \.id) { event in
                            EventCardView(event: event)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
                Button("Sign Out") {
                    print("Signing out: isLoggedIn set to false")
                            isLoggedIn = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .buttonStyle(.bordered)
                        .foregroundColor(.red)
            }
            .navigationTitle("My Dashboard")
            .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       NavigationLink(destination: EditProfileView()) {
                           Image(systemName: "pencil")
                       }
                   }
               }
        }
    }

    // 简化的数据过滤逻辑
    func filteredEvents() -> [Event] {
        switch selectedTab {
        case "Favorites":
            return Array(eventVM.allEvents.prefix(1)) // 模拟收藏
        case "Following":
            return Array(eventVM.allEvents.dropFirst(1)) // 模拟关注
        default:
            return eventVM.allEvents
        }
    }
}
#Preview {
    DashboardView()
        .environmentObject(EventViewModel())
}
