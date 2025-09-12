//
//  MainViewViewModel.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUser: User? = nil
    
    init() {
        _ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self, let uid = user?.uid else {
                DispatchQueue.main.async {
                    self?.currentUser = nil
                }
                return
            }
            
            // Firestore'dan kullanıcı bilgilerini çek
            let db = Firestore.firestore()
            db.collection("users").document(uid).getDocument { snapshot, error in
                if let data = snapshot?.data(), error == nil {
                    if let id = data["id"] as? String,
                       let name = data["name"] as? String,
                       let email = data["email"] as? String,
                       let joined = data["joined"] as? TimeInterval {
                        DispatchQueue.main.async {
                            self.currentUser = User(id: id, name: name, email: email, joined: joined)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.currentUser = nil
                    }
                }
            }
        }
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
