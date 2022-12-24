//
//  Response.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

// Все типы опциональные т.к это зачита если с бэка что-нибудь не придёт
// При создании Респонс нужно соблюдать два важных условия. 1 - все поля респонса должны быть идентичны полям которые приходят с бэка.

import UIKit
import Foundation

// MARK: - LocationModel
struct LocationResponse: Codable {
    let info: InfoLocation
    let results: [Location]
}

// MARK: - Info
struct InfoLocation: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct Location: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}


enum ArticleType: String, Codable {
    case special
    case idea
}

enum ColorType: String, Codable {
    case red
    case black
}
// MARK: - CharacterResponse
struct CharacterResponse: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: LocationCharacters
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct LocationCharacters: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
