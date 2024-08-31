//
//  TabBarView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 26/08/24.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject var userAuth: UserAuthentication
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AllTaskView()
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.circle")
                }
            
            ProfileView(userAuth: userAuth)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

