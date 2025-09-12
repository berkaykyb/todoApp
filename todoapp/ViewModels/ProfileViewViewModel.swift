//
//  ProfileViewViewModel.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewViewModel: ObservableObject {
    @Published var user: User? = nil

    init() {
        fetchUser()
    }

    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users")
            .document(userId)
            .getDocument() { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                DispatchQueue.main.async {
                    self?.user = User(
                        id: data["id"] as? String ?? "",
                        name: data["name"] as? String ?? "",
                        email: data["email"] as? String ?? "",
                        joined: data["joined"] as? TimeInterval ?? 0,
                        image: data["image"] as? String
                    )
                }
            }
    }

    func uploadProfileImage(image: UIImage) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }

        let storageRef = Storage.storage().reference().child("profileImages/\(userId).jpg")

        storageRef.putData(imageData, metadata: nil) { _, error in
            guard error == nil else { return }

            storageRef.downloadURL { url, error in
                guard let url = url, error == nil else { return }

                Firestore.firestore()
                    .collection("users")
                    .document(userId)
                    .updateData(["image": url.absoluteString]) { error in
                        guard error == nil else { return }
                        DispatchQueue.main.async { [weak self] in
                            self?.fetchUser()
                        }
                    }
            }
        }
    }

    func updateName(newName: String) {
        guard !newName.isEmpty, let userId = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore()
            .collection("users")
            .document(userId)
            .updateData(["name": newName]) { [weak self] error in
                guard error == nil else { return }
                DispatchQueue.main.async {
                    self?.fetchUser()
                }
            }
    }

    func logout() {
        do { try Auth.auth().signOut() }
        catch { print(error) }
    }
}
