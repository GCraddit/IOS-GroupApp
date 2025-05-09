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

        var body: some Scene {
            WindowGroup {
                HomeView()
                    .environmentObject(eventVM)
            }
    }
}
