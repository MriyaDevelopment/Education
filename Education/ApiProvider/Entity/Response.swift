//
//  Response.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import Foundation

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
