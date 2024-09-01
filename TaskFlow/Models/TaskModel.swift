//
//  TaskModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 27/08/24.
//

import Foundation

struct TaskResponse: Codable {
    let statusCode: Int?
    let data: [Task]?
    let message: String?
    let success: Bool?
}

struct Task: Codable, Identifiable {
    let id, title, desc, status: String
    let user, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, desc, status, user, createdAt, updatedAt
        case v = "__v"
    }
}

enum Status: String, Codable {
    case pending = "pending"
    case inProgress = "inProgress"
    case completed = "completed"
}


struct addTaskResponse: Codable {
    let statusCode: Int?
    let data: Task?
    let message: String?
    let success: Bool?
}





