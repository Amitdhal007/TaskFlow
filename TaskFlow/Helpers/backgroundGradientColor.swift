//
//  backgroundGradientColor.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 27/08/24.
//

import SwiftUI

func getBackgroundGradient(status: Status) -> LinearGradient {
    switch status {
        case .pending:
            return LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.4098440409, green: 0.05219335854, blue: 0.02931869961, alpha: 1))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .inProgress:
            return LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .completed:
            return LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
    }
}
