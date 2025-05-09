//
//  HomeView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 9/5/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var eventVM: EventViewModel

    var body: some View {
        NavigationView {
            List(eventVM.allEvents) { event in
                Text(event.title)
            }
            .navigationTitle("Local Explorer")
        }
    }
}
