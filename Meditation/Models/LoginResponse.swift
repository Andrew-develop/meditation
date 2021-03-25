//
//  File.swift
//  Meditation
//
//  Created by Sergio Ramos on 20.03.2021.
//

import Foundation

struct LoginResponse: Codable {
    let id, email, nickName: String
    let avatar: String
    let token: String
}
