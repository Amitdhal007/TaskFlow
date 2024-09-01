//
//  AddTaskView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 26/08/24.
//

import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedStatus: Status = .pending
    @ObservedObject var taskViewModel: TaskViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    TextField("Enter task title...", text: $title)
                        .padding()
                        .frame(height: 60)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    TextField("Enter task description...", text: $description)
                        .padding()
                        .frame(height: 60)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                    Picker("Select Status", selection: $selectedStatus) {
                        Text("pending").tag(Status.pending)
                        Text("inProgress").tag(Status.inProgress)
                        Text("completed").tag(Status.completed)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                    Button(action: {
                        taskViewModel.addTask(title: title, description: description, selectedStatus: selectedStatus)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Task")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(10)
                            
                    }
                }
                .padding(.horizontal)
                .padding(.top, 40)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModel())
}
