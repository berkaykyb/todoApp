//
//  ItemView.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 5.09.2025.
//

import SwiftUI

struct ItemView: View {
    let item: ToDoListItem
    var body: some View {
        VStack{
            Text(item.title)
                .font(.title)
                .bold()
            Text("Bitiş Tarihi : \(Date(timeIntervalSince1970: item.dueDate).formatted(date:.abbreviated, time:.shortened))")
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text((item.details ?? "").isEmpty ? "Açıklama Yok" : (item.details ?? ""))
                .font(.body)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ItemView(item: ToDoListItem(
        id: "123",
        title: "Test Item",
        details: "Açıklama",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        isDone: false))
}
