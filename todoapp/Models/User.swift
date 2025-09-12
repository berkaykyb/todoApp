//
//  User.swift
//  todoapp
//
//  Created by Berkay KAYABAŞI on 3.09.2025.
//

import Foundation

struct User: Codable{
    let id: String
    var name: String
    let email: String
    let joined: TimeInterval
    var image: String?
}
