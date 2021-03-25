//
//  Feelings.swift
//  Meditation
//
//  Created by Sergio Ramos on 22.03.2021.
//

import Foundation

struct Feelings: Codable {
    let success: Bool
    let data: [Feeling]
}

struct Feeling: Codable {
    let id: Int
    let title: String
    let position: Int
    let image: String
}
