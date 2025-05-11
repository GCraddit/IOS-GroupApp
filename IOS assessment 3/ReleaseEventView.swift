//
//  ReleaseEventView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI
import CoreLocation
import MapKit

struct ReleaseEventView: View {
    @EnvironmentObject var eventVM: EventViewModel
    @EnvironmentObject var userSession: UserSession
    @State private var showLoginSheet = false
    @Environment(\.dismiss) var dismiss
    @Binding var selectedTab: Int
    @State private var selectedCoordinate = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @State private var showGeocodeError = false
    @State private var geocodeErrorMessage = ""


    @State private var title = ""
    @State private var address = ""
    @State private var maxPeople = ""
    @State private var summary = ""
    @State private var category = "Food"
    @State private var imageName = "bbq"

    let categoryOptions = ["Food", "Music", "Art", "Market", "Sports"]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Event Name").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextField("Add event name", text: $title)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Address").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextField("Add address", text: $address)
                        .onSubmit {
                            geocodeAddress()
                        }
//                        .onChange(of: address) { _ in
//                            geocodeAddress()
//                        }
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Maximum number of people").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextField("e.g. 10", text: $maxPeople)
                        .keyboardType(.numberPad)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Select Image")) {
                    Picker("Cover Image", selection: $imageName) {
                        ForEach(ImageAssets.eventImages, id: \.self) { name in
                            Text(name.capitalized).tag(name)
                        }
                    }
                    .pickerStyle(.menu)

                    // ✅ 用户选择后显示当前图片
                    if !imageName.isEmpty {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 180)
                            .cornerRadius(AppStyle.cardCornerRadius)
                            .padding(.top, 8)
                    }
                }


                Section(header: Text("Select Category").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    Picker("Category", selection: $category) {
                        ForEach(categoryOptions, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section(header: Text("Summary").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextEditor(text: $summary)
                        .frame(minHeight: 80)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }
                Section(header: Text("Location").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    MapSelectorView(
                        selectedCoordinate: $selectedCoordinate,
                        region: $region
                    )
                    .frame(height: 200)

                    Text("Lat: \(selectedCoordinate.latitude), Lon: \(selectedCoordinate.longitude)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }


                Button("Post") {
                    let newEvent = Event(
                        title: title,
                        organizer: userSession.currentUser?.name ?? "Unknown",
                        address: address,
                        summary: summary,
                        date: Date(),
                        imageName: imageName,
                        category: category,
                        maxPeople: Int(maxPeople) ?? 10,
                        interestedCount: 0,
                        location: selectedCoordinate
                    )
                    
                    eventVM.allEvents.append(newEvent)
                    eventVM.lastAddedEvent = newEvent

                    // ✅ 商户发布后，推送给附近用户
                    if userSession.currentUser?.isMerchant == true {
                        userSession.sendNotificationToNearbyUsers(for: newEvent)
                    }
                    title = ""
                    address = ""
                    maxPeople = ""
                    summary = ""
                    category = categoryOptions.first ?? "Food"
                    imageName = ImageAssets.eventImages.first ?? "bbq"
                    selectedCoordinate = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)
                    region = MKCoordinateRegion(
                        center: selectedCoordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )

                    selectedTab = 0
                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("New Event")
        }
        .onAppear {
            if userSession.currentUser == nil {
                showLoginSheet = true
            }
        }
        .sheet(isPresented: $showLoginSheet, onDismiss: {
            if userSession.currentUser == nil {
                selectedTab = 0 // ✅ 自动跳回首页 tab
            }
        }) {
            SignInView()
                .environmentObject(userSession)
                .interactiveDismissDisabled(false)
        }
        .alert("Location Not Found", isPresented: $showGeocodeError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(geocodeErrorMessage)
        }

    }
    func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let location = placemarks?.first?.location {
                selectedCoordinate = location.coordinate
                region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            } else {
                geocodeErrorMessage = "Could not locate the address. Please try again or tap the map manually."
                showGeocodeError = true
            }
        }
    }


}

#Preview {
    ReleaseEventView(selectedTab: .constant(0))
        .environmentObject(EventViewModel())
        .environmentObject(UserSession())
}
