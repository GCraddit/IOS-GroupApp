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
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(eventVM.allEvents) { event in
                        NavigationLink {
                            EventDetailView(event: event)
                        } label: {
                            EventCardView(event: event)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Local Explorer")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(EventViewModel())
}

