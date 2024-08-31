//
//  TaskModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 27/08/24.
//

import Foundation

struct Task: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let desc: String
    let status: Status
}

enum Status {
    case pending
    case inProgress
    case completed
}



