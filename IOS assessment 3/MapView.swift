//
//  MapView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var eventVM: EventViewModel

    // 地图默认中心坐标（悉尼）
    private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    var body: some View {
        NavigationStack {
            Map(initialPosition: .region(region)) {
                ForEach(eventVM.allEvents) { event in
                    Annotation(event.title, coordinate: event.location) {
                        NavigationLink(destination: EventDetailView(event: event)) {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.red)
                                Text(event.title)
                                    .font(.caption)
                                    .fixedSize()
                            }
                        }
                    }
                }
            }

            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Map View")
        }
    }
}

#Preview {
    MapView()
        .environmentObject(EventViewModel())
}
