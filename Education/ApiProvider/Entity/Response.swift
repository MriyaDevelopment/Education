//
//  Response.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import Foundation

// MARK: - LocationModel
struct LocationResponse: Codable {
    let info: Info
    let results: [Location]
}

// MARK: - Info
struct Info: Codable {
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


struct ArticlesResponse: Codable {
    let error: String?
    let result: String?
    let articles: [Article]?
}

struct Article: Codable {
    let id: Int?
    let type: ArticleType?
    let image: String?
    let title: String?
    let description: String?
    let color: ColorType?
    let article_type: String?
}

enum ArticleType: String, Codable {
    case special
    case idea
}

enum ColorType: String, Codable {
    case red
    case black
}
