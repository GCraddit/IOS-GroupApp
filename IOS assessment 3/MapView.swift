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
    @State private var searchText: String = ""
    @State private var selectedEvent: Event? = nil
    @State private var showDetail: Bool = false
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // More Focus
    )
    @State private var selectedRegion: String = "All"
    let regionOptions = ["All", "UTS", "CBD", "North"]
    



    var body: some View {
        NavigationStack {
            NavigationStack {
                VStack(spacing: 0) {
                    // Search bar
                    TextField("Search", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding()
                    
                    Picker("Area", selection: $selectedRegion) {
                        ForEach(regionOptions, id: \.self) { region in
                            Text(region)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    
                    ZStack(alignment: .bottom) {
                        // map
                        Map(coordinateRegion: $region, annotationItems: filteredEvents()) { event in
                            MapAnnotation(coordinate: event.location) {
                                VStack(spacing: 4) {
                                    //  Event title box
                                    Text(event.title)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color(.systemBackground))
                                        .cornerRadius(AppStyle.cardCornerRadius)
                                        .shadow(color: AppStyle.cardShadow, radius: AppStyle.cardShadowRadius)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    Button {
                                        // Adjust map center & popup card after clicking
                                        let offsetLat = event.location.latitude - 0.005
                                        region.center = CLLocationCoordinate2D(latitude: offsetLat, longitude: event.location.longitude)
                                        region.span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                                        
                                        selectedEvent = event
                                        showDetail = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            showDetail = true
                                        }
                                    } label: {
                                        Image(systemName: "mappin.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                        Spacer()
                        
                        // Click to close the area (only appears when the card is displayed)
                        if selectedEvent != nil {
                            Color.black.opacity(0.001)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    withAnimation {
                                        showDetail = false
                                        selectedEvent = nil
                                    }
                                }
                        }
                        
                        // Card display
                        if let event = selectedEvent, showDetail {
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EventCardView(event: event)
                                    .padding()
                                    .background(Color(.systemBackground))
                                    .cornerRadius(AppStyle.cardCornerRadius)
                                    .shadow(radius: 4)
                                    .padding(.bottom, 12)
                            }
                            .buttonStyle(.plain)
                            .transition(.move(edge: .bottom))
                        }
                    }
                }
            }
        }
                .navigationTitle("Map View")
                .onAppear {
                    if let last = eventVM.lastAddedEvent {
                        region.center = last.location
                        region.span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                        eventVM.lastAddedEvent = nil // ✅
                    }
                }

            }


    func filteredEvents() -> [Event] {
        // Step 1: Search text filtering
        let searchFiltered = eventVM.allEvents.filter {
            searchText.isEmpty || (
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.address.localizedCaseInsensitiveContains(searchText) ||
                $0.organizer.localizedCaseInsensitiveContains(searchText) ||
                $0.category.localizedCaseInsensitiveContains(searchText)
            )
        }

        // Step 2: Regional screening
        return searchFiltered.filter { event in
            switch selectedRegion {
            case "UTS":
                return coordinateInBox(event.location, latMin: -33.886, latMax: -33.881, lonMin: 151.198, lonMax: 151.206)
            case "CBD":
                return coordinateInBox(event.location, latMin: -33.875, latMax: -33.87, lonMin: 151.203, lonMax: 151.22)
            case "North":
                return event.location.latitude < -33.85 //sample
            default:
                return true
            }
        }
    }
    
    func coordinateInBox(_ coord: CLLocationCoordinate2D, latMin: Double, latMax: Double, lonMin: Double, lonMax: Double) -> Bool {
        return coord.latitude >= latMin && coord.latitude <= latMax &&
               coord.longitude >= lonMin && coord.longitude <= lonMax
    }

}

#Preview {
    MapView()
        .environmentObject(EventViewModel())
}
