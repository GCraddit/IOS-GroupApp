//
//  SignInViewWrapper.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 11/5/2025.
//

import SwiftUI

struct SignInViewWrapper: View {
    @EnvironmentObject var userSession: UserSession
    @Binding var selectedTab: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        SignInView()
            .onDisappear {
                if userSession.currentUser == nil {
                    selectedTab = 0
                }
            }
    }
}
