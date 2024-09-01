//
//  ProfileView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 27/08/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var userAuth: UserAuthentication
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("A")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: 100, height: 100)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                    
                    Text(UserDefaults.standard.string(forKey: "userName") ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    VStack {
                        Text("Personal Information")
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)
                    }
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        VStack {
                            VStack {
                                Text(UserDefaults.standard.string(forKey: "userName") ?? "")
                                    .padding(.leading, 20)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 66)
                            .background(Color(.systemGray6))
                            .cornerRadius(15)
                        }
                        
                        VStack {
                            VStack {
                                Text(UserDefaults.standard.string(forKey: "email") ?? "")
                                    .padding(.leading, 20)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 66)
                            .background(Color(.systemGray6))
                            .cornerRadius(15)
                        }
                    }
                    
                    VStack {
                        Button(action: {
                            userAuth.logOutUser()
                        }, label: {
                            VStack {
                                Text("Log Out")
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 66)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                        })
                    }
                }
            }
            .navigationTitle("Profile")
            .padding(.horizontal, 16)
        }
    }
}

