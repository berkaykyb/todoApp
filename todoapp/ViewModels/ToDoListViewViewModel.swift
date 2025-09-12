//
//  ToDoListViewViewModel.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//
import FirebaseFirestore
import Foundation

class ToDoListViewViewModel:ObservableObject{
    @Published var showingNewItemView: Bool = false
    private let userId: String
    init(userId: String){
        self.userId = userId
    }
    
    /// Delete todo list item
    /// - Parameter id: Item id to delete
    func delete(id: String){
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
}
