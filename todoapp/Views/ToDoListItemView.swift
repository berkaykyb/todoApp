//
//  ToDoListItemView.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//

import FirebaseFirestore
import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    let item: ToDoListItem
    @State private var showItemSheet = false
    
    private var isOverDue: Bool {
        Date() > Date(timeIntervalSince1970: item.dueDate)
    }
    
    private var rowBackgroundColor: Color {
        if isOverDue {
            return item.isDone ? Color.green.opacity(0.3) : Color.red.opacity(0.3)
        }else {
            if item.isDone {
                return Color.green.opacity(0.3)
            }else {
                return Color.clear
            }
        }
    }
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(item.title)
                    .font(.title)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date:.abbreviated, time:.shortened))")
                    .font(.footnote)
                    .foregroundStyle(Color(.secondaryLabel))
            }
            Spacer()
            
            // Circle butonu
            Button{
                viewModel.toggleIsDone(item: item)
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(.blue)
                    .font(.title2)
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(rowBackgroundColor)
        .cornerRadius(8)
        .contentShape(Rectangle())
        .onTapGesture {
            showItemSheet = true
        }
        .sheet(isPresented: $showItemSheet) {
            ItemView(item: item)
        }
    }
}

#Preview {
    ToDoListItemView(item: ToDoListItem(
        id: "123",
        title: "Test Item",
        details: "Açıklama",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: false))
}
