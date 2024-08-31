//
//  AllTaskView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 26/08/24.
//

import SwiftUI

struct AllTaskView: View {
    @State private var selectedSegment = 0
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    let segments = ["All", "Pending", "Completed"]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Task Status", selection: $selectedSegment) {
                    ForEach(0..<3) { index in
                        Text(segments[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Content changes based on selected segment
                if selectedSegment == 0 {
                    ScrollView {
                        VStack {
                            ForEach(taskViewModel.taskArray) { task in
                                NavigationLink(destination: DetailedTaskView(task: task), label: {
                                    VStack {
                                        Text(task.title)
                                            .font(.headline)
                                            .padding()
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .frame(height: 120)
                                    .background(getBackgroundGradient(status: task.status)
                                        .edgesIgnoringSafeArea(.all))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                })
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                } else if selectedSegment == 1 {
                    ScrollView {
                        VStack {
                            ForEach(taskViewModel.taskArray) { task in
                                NavigationLink(destination: DetailedTaskView(task: task), label: {
                                    VStack {
                                        Text(task.title)
                                            .font(.headline)
                                            .padding()
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .frame(height: 120)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.4098440409, green: 0.05219335854, blue: 0.02931869961, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .edgesIgnoringSafeArea(.all))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                })
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                } else {
                    ScrollView {
                        VStack {
                            ForEach(taskViewModel.taskArray) { task in
                                NavigationLink(destination: DetailedTaskView(task: task), label: {
                                    VStack {
                                        Text(task.title)
                                            .font(.headline)
                                            .padding()
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                    .frame(height: 120)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .edgesIgnoringSafeArea(.all))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                })
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    AllTaskView()
}


