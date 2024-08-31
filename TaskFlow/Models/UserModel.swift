//
//  UserModel.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 30/08/24.
//

import Foundation

struct User : Identifiable {
    let id: String = UUID().uuidString
    let userName: String
    let email: String
}
