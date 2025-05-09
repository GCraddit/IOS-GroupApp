//
//  EditProfileView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct EditProfileView: View {
    @State private var name: String = "Helena"
    @State private var bio: String = "City Explorer and foodie!"
    @State private var showSavedAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile Picture")) {
                    HStack {
                        Spacer()
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .padding()
                        Spacer()
                    }
                }

                Section(header: Text("Name")) {
                    TextField("Your name", text: $name)
                }

                Section(header: Text("Bio")) {
                    TextEditor(text: $bio)
                        .frame(height: 100)
                }

                Button("Save Changes") {
                    showSavedAlert = true
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderedProminent)
                .alert("Profile Updated!", isPresented: $showSavedAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .navigationTitle("Edit Profile")
        }
    }
}
#Preview {
    EditProfileView()
}
