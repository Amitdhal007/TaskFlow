//
//  UserViewModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 30/08/24.
//

import Foundation

class UserAuthentication : ObservableObject {
    
    let base_url: String = "http://localhost:5955/api/v1/"
    @Published var isRegistered = false
    @Published var isLoggedIn = false
    
    func registerUser(userName: String, email: String, password: String) {
        
        guard let url = URL(string: base_url + "users/register") else {
            print("Invalid URL for registration")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = ["userName": userName, "email": email, "password": password]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error while registering user: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 201 {
                        self.isRegistered = true
                    }
                    else {
                        print("Registration failed with statusCode: \(httpResponse.statusCode)")
                    }
                }
            }
            
        }.resume()
        
    }
    
    func loginUser(email: String, password: String) {
        guard let url = URL(string: base_url + "users/login") else {
            print("Invalid URL for login")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error logging in user: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decodedResponse = try JSONDecoder().decode(UserResponse.self, from: data)

                    if let userData = decodedResponse.data, 
                       let accessToken = userData.accessToken,
                       let userID = userData.user?.id,
                       let email = userData.user?.email,
                       let userName = userData.user?.userName{
                        
                        DispatchQueue.main.async {
                            
                            // Save data into UserDefaults
                            UserDefaults.standard.set(accessToken, forKey: "accessToken")
                            UserDefaults.standard.set(userID, forKey: "userID")
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.set(userName, forKey: "userName")
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            self.isLoggedIn = true
                            
                        }
                        
                    }
                    
                }
                catch {
                    print("Failed to parse JSON response")
                }
            }
        }.resume()
        
    }
    
    func logOutUser () {
        guard let url = URL(string: base_url + "users/logout") else {
            print("Invalid Logout URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = ["userId": UserDefaults.standard.string(forKey: "userID")]
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        
        // add accessToken into req header
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error in logOut: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        UserDefaults.standard.removeObject(forKey: "accessToken")
                        UserDefaults.standard.removeObject(forKey: "userID")
                        UserDefaults.standard.removeObject(forKey: "email")
                        UserDefaults.standard.removeObject(forKey: "userName")
                        UserDefaults.standard.set(false, forKey: "isLoggedIn")
                        self.isLoggedIn = false
                    }
                    else {
                        print("Logout Failed with StatusCode: \(httpResponse.statusCode)")
                    }
                }
            }
        }.resume()
    }
    
}
