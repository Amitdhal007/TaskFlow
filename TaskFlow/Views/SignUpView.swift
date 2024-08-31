//
//  SignUpView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 29/08/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var userAuth: UserAuthentication
    
    var body: some View {
            ScrollView {
                VStack(alignment: .center, spacing: 24) {
                    Spacer()
                    
                    Image(systemName: "pencil.and.list.clipboard")
                        .font(.system(size: 160))
                        .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.8)))
                    
                    Spacer()
                    
                    VStack(spacing: 12) {
                        TextField("Enter Your userName", text: $userName)
                            .padding()
                            .frame(height: 60)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        TextField("Enter Your email", text: $email)
                            .padding()
                            .frame(height: 60)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        SecureField("Enter Your password", text: $password)
                            .padding()
                            .frame(height: 60)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                    
                    VStack {
                        Button(action: {
                            userAuth.registerUser(userName: userName, email: email, password: password)
                        }, label: {
                            Text("Login")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .fontWeight(.bold)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                    }
                }
                .padding(EdgeInsets(top: 24, leading: 16, bottom: 16, trailing: 16))
            }
            .navigationTitle("Sign Up")
            .fullScreenCover(isPresented: $userAuth.isRegistered) {
                LogInView(userAuth: userAuth)
            }
        }
    }

