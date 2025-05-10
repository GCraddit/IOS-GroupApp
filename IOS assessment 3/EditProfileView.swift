//
//  EditProfileView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI
import MapKit

struct EditProfileView: View {

    @State private var showSavedAlert = false
    @EnvironmentObject var userSession: UserSession
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var avatar: String = "profile1"

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile Picture").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    HStack {
                        Spacer()
                        Image(avatar)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        Spacer()
                    }
                }

                Section(header: Text("Name").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    TextField("Your name", text: $name)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Email").font(.caption).foregroundColor(AppStyle.secondaryText)) {
                    Text(email)
                        .padding(8)
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(AppStyle.cardCornerRadius)
                }

                Section(header: Text("Select Avatar")) {
                    Picker("Avatar", selection: $avatar) {
                        ForEach(ImageAssets.avatars, id: \.self) { name in
                            Text(name.capitalized).tag(name)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Button("Save Changes") {
                    guard let id = userSession.currentUser?.id,
                          let index = userSession.allUsers.firstIndex(where: { $0.id == id }) else {
                        return
                    }
                    userSession.allUsers[index].name = name
                    userSession.allUsers[index].avatarImage = avatar
                    userSession.currentUser = userSession.allUsers[index]
                    showSavedAlert = true
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .buttonStyle(.borderedProminent)
                .alert("Profile Updated!", isPresented: $showSavedAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .onAppear {
                if let user = userSession.currentUser {
                    name = user.name
                    email = user.email
                    avatar = user.avatarImage
                }
            }

            .navigationTitle("Edit Profile")
        }
    }
}

#Preview {
    let userSession = UserSession()
    userSession.currentUser = User(
        name: "PreviewUser",
        email: "preview@example.com",
        password: "123",
        avatarImage: "profile1",
        isMerchant: false,
        preferredLocation: CLLocationCoordinate2D(latitude: -33.0, longitude: 151.0),
        createdEvents: [],
        favoriteEvents: []
    )

    return NavigationStack {
        EditProfileView()
            .environmentObject(userSession)
    }
}



