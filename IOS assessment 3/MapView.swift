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
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // 更聚焦
    )


    var body: some View {
        NavigationStack {
            NavigationStack {
                VStack(spacing: 0) {
                    // 搜索栏
                    TextField("Search", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding()
                    
                    ZStack(alignment: .bottom) {
                        // 🗺️ 地图
                        Map(coordinateRegion: $region, annotationItems: filteredEvents()) { event in
                            MapAnnotation(coordinate: event.location) {
                                Button {
                                    // ✅ 居中位置往上偏移 0.01 度，避免被卡片遮挡
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
                        Spacer()
                        
                        // 🖱️ 点击关闭区域（仅当卡片显示时出现）
                        if selectedEvent != nil {
                            Color.black.opacity(0.001) // 看不见但能点
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    withAnimation {
                                        showDetail = false
                                        selectedEvent = nil
                                    }
                                }
                        }
                        
                        // \ud83d\udcc3 卡片展示
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
                }}}
                .navigationTitle("Map View")
            }


    func filteredEvents() -> [Event] {
        if searchText.isEmpty {
            return eventVM.allEvents
        } else {
            return eventVM.allEvents.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.address.localizedCaseInsensitiveContains(searchText) ||
                $0.organizer.localizedCaseInsensitiveContains(searchText) ||
                $0.category.localizedCaseInsensitiveContains(searchText)
            }

        }
    }
}

#Preview {
    MapView()
        .environmentObject(EventViewModel())
}
