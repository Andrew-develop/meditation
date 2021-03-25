//
//  Quotes.swift
//  Meditation
//
//  Created by Sergio Ramos on 20.03.2021.
//

import Foundation

struct Quotes: Codable {
    let success: Bool
    let data: [Quote]
}

struct Quote: Codable {
    let id: Int
    let title: String
    let image: String
    let datumDescription: String

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case datumDescription = "description"
    }
}
