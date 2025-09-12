//
//  LoginViewViewModel.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//
import FirebaseAuth
import Foundation

class LoginViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    init(){}
    
    func login(){
        guard validate()
        else{
            return
        }
        Auth.auth().signIn(withEmail: email,password: password)
    }
    
    private func validate() -> Bool{
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else{
            errorMessage = "Lütfen email ve parola alanlarını boş bırakmayınız."
            return false
        }
        
        guard email.contains("@") && email.contains(".")
        else {
            errorMessage = "Geçerli bir email adresi giriniz."
            return false
        }
        return true
    }
}
