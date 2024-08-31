//
//  UserViewModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 30/08/24.
//

import Foundation

class UserAuthentication : ObservableObject {
    
    let base_url: String = "http://localhost:5956/api/v1/"
    @Published var isRegistered = false
    @Published var isLoggedIn = false
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var userId: String = ""
    
    func registerUser(userName: String, email: String, password: String) {
        
        guard let url = URL(string: base_url + "users/register") else {
            print("Invalid URL for registration")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyData = ["userName": userName, "email": email, "password": password]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let userData = jsonResponse["data"] as? [String: Any],
                       let user = userData["user"] as? [String: Any],
                       let accessToken = userData["accessToken"] as? String {
                        
                        DispatchQueue.main.async {
                            self.userName = user["userName"] as? String ?? ""
                            self.email = user["email"] as? String ?? ""
                            self.userId = user["_id"] as? String ?? ""
                            self.isLoggedIn = true
                            
                            // save accessToken into userDefault
                            UserDefaults.standard.set(accessToken, forKey: "accessToken")
                            print("\(UserDefaults.standard.string(forKey: "accessToken")!)")
                        }
                    }
                }
                catch {
                    print("Failed to parse JSON response")
                }
            }
        }.resume()
        
    }
    
    func logOutUser (userId: String) {
        guard let url = URL(string: base_url + "users/logout") else {
            print("Invalid Logout URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = ["userId": userId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        
        // add accessToken into req header
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Error in logOut: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                DispatchQueue.main.async {
                    if httpResponse.statusCode == 200 {
                        self.isLoggedIn = false
                        
                        // remove from userDefaults
                        UserDefaults.standard.removeObject(forKey: "accessToken")
                    }
                    else {
                        print("Logout Failed with StatusCode: \(httpResponse.statusCode)")
                    }
                }
            }
        }.resume()
    }
    
}
