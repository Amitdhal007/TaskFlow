//
//  HomeView.swift
//  TaskFlow
//
//  Created by Amit Kumar Dhal on 26/08/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showModal = false
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                
                ScrollView {
                    
                    VStack {
                        Text("Today Tasks")
                            .font(.title2)
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack {
                        ForEach(taskViewModel.todayTask) { task in
                            NavigationLink(destination: DetailedTaskView(task: task), label: {
                                VStack {
                                    Text(task.title)
                                        .font(.headline)
                                        .padding()
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .frame(height: 120)
                                .background(getBackgroundGradient(status: Status(rawValue: task.status) ?? .pending))
                                .edgesIgnoringSafeArea(.all)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            })
                            .contextMenu {
                                Button(action: {
                                    taskViewModel.deleteTask(id: task.id)
                                }, label: {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                })
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("Cancel")
                                    Image(systemName: "xmark")
                                })
                                
                                Button(action: {
                                    
                                }, label: {
                                    Text("Update")
                                    Image(systemName: "xmark")
                                })
                            }
                        }
                    }
                }
                .navigationBarItems(trailing: Button(action: {
                    showModal = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.8)))
                        .fontWeight(.bold)
                })
                .navigationTitle("Home")
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
            .sheet(isPresented: $showModal) {
                AddTaskView(taskViewModel: taskViewModel)
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HomeView()
}
