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
    @State private var selectedTab = "My Events"
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true
    @State private var showLoginSheet = false

    let tabs = ["My Events", "Favorites", "Following"]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 用户头部
                HStack(spacing: 16) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(AppStyle.primaryColor)

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
                Picker("Select", selection: $selectedTab) {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, AppStyle.cardPadding)
                .padding(.top)

                // 卡片列表
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredEvents(), id: \.id) { event in
                            EventCardView(event: event)
                        }
                    }
                    .padding(.horizontal, AppStyle.cardPadding)
                }

                Spacer()

                // 退出按钮
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
            // 如果用户仍未登录，自动关闭页面
            if userSession.currentUser == nil {
                dismiss()
            }
        }) {
            SignInView()
                .environmentObject(userSession)
                .interactiveDismissDisabled(false) // ✅ 允许下滑关闭
        }
    }
    

    // 数据过滤逻辑
    func filteredEvents() -> [Event] {
        let userName = userSession.currentUser?.name ?? ""

        switch selectedTab {
        case "Favorites":
            return userSession.currentUser?.favoriteEvents ?? []
        case "Following":
            return [] // 如果你未来有“关注其他用户”的逻辑可以填这里
        default:
            return eventVM.allEvents.filter { $0.organizer == userName }
        }
    }

}

#Preview {
    DashboardView()
        .environmentObject(EventViewModel())
        .environmentObject(UserSession())
}
