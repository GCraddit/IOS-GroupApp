//
//  SignInView.swift
//  IOS assessment 3
//
//  Created by GILES CHEN on 10/5/2025.
//

import SwiftUI

struct SignInView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // 邮箱输入
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                // 密码输入
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                // 登录按钮
                Button("Sign In") {
                    print("Logging in: isLoggedIn set to true")
                    if email.isEmpty || password.isEmpty {
                        showError = true
                    } else {
                        isLoggedIn = true
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
