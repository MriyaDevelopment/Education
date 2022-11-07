//
//  ApiClient.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import Foundation
import Combine

protocol ApiClientProtocol {
    func getArticles() -> AnyPublisher<ArticlesResponse, Error>
}

private func getPath(for method: String) -> String {
    return "/public/api/\(method)"
}

extension ApiClient: ApiClientProtocol {
    
//MARK: GET methods
    
    func getArticles() -> AnyPublisher<ArticlesResponse, Error> {
        let request = requestBuilder.requestBuild(
            path: getPath(for: "getArticles"),
            urlParametrs: [:])
        return performRequest(request)
    }
}
