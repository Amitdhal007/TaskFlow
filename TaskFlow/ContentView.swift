//
//  ContentView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userAuth: UserAuthentication = UserAuthentication()
    
    var body: some View {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            TabBarView(userAuth: userAuth)
        }
        else {
            InitialSplashView(userAuth: userAuth)
        }
    }
}

#Preview {
    ContentView()
}
