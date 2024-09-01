//
//  UserModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 30/08/24.
//

import Foundation

//struct User : Identifiable {
//    let id: String = UUID().uuidString
//    let userName: String
//    let email: String
//}

struct UserResponse: Codable {
    let statusCode: Int?
    let data: UserModel?
    let message: String?
    let success: Bool?
}

struct UserModel: Codable {
    let user: User?
    let accessToken, refreshToken: String?
}

struct User: Codable {
    let id, userName, email, createdAt: String?
    let updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userName, email, createdAt, updatedAt
        case v = "__v"
    }
}
