//
//  IOS_assessment_3App.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 4/5/2025.
//

import SwiftUI

@main
struct IOS_assessment_3App: App {
    @StateObject var eventVM = EventViewModel()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @StateObject var userSession = UserSession()
    @State private var selectedTab = 0

    
    
    var body: some Scene {
        WindowGroup {
            MainTabView(selectedTab: $selectedTab)
                .transition(.opacity)
                .environmentObject(userSession)
                .environmentObject(eventVM)
        }
    }
}
