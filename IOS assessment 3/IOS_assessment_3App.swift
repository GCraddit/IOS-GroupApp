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
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false// 默认没有登录
    @StateObject var userSession = UserSession()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .transition(.opacity)
                .environmentObject(userSession)
                .environmentObject(eventVM)
        }
    }
}
