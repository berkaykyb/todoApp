//
//  todoappApp.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//
import FirebaseCore
import SwiftUI

@main
struct todoappApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
