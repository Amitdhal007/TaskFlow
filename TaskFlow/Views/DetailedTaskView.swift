//
//  DetailedTaskView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 26/08/24.
//

import SwiftUI

struct DetailedTaskView: View {
    let task: Task
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Task Title
                    VStack(alignment: .leading, spacing: 10) {
                        Text(task.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.getForegroundColor(status: task.status))

                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                            Text("30 minutes")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
                    
                    // Task Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(self.getForegroundColor(status: task.status))

                        Text(task.desc)
                            .font(.body)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 4)
                    
                }
                .padding(.horizontal, 10)
                
                
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func getForegroundColor(status: Status) -> Color {
        switch status {
        case .pending:
            return Color.red
        case .inProgress:
            return Color.blue
        case .completed:
            return Color.green
        }
    }
}

#Preview {
    DetailedTaskView(task: Task(title: "Task1", desc: "Hello my name is amit", status: .completed))
}
