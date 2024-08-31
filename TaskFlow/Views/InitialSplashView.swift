//
//  InitialSplashView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 29/08/24.
//

import SwiftUI

struct InitialSplashView: View {
    @ObservedObject var userAuth: UserAuthentication
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 24) {
                    Spacer()
                    
                    Image(systemName: "pencil.and.list.clipboard")
                        .font(.system(size: 160))
                        .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.8)))
                    
                    Spacer()
                    
                    VStack(alignment: .center){
                        Text("Welcome to TaskFlow")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Text("One stop solution for Managing Task")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color(.systemGray))
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 16) {
                        
                        NavigationLink(destination: LogInView(userAuth: userAuth), label: {
                            Text("Continue")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .fontWeight(.bold)
                                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                        
                        HStack{
                            NavigationLink(destination: SignUpView(userAuth: userAuth), label: {
                                Text("Sign up")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.8)))
                            })
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(EdgeInsets(top: 48, leading: 16, bottom: 16, trailing: 16))
            }
            .scrollIndicators(.hidden)
        }
    }
}
