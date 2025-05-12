//
//  SignInView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct SignInView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @EnvironmentObject var userSession: UserSession
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @Environment(\.dismiss) var dismiss


    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)

                // email
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(AppStyle.cardCornerRadius)

                // Password Input
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(AppStyle.cardCornerRadius)

                // Login Button
                Button("Sign In") {
                    if email.isEmpty || password.isEmpty {
                        showError = true
                    } else if userSession.login(email: email, password: password) {
                        isLoggedIn = true
                        dismiss()
                    } else {
                        showError = true
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .alert("Email and password cannot be empty.", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            }
            .navigationTitle("Sign In")
        }
    }
}


#Preview {
    SignInView()
}
