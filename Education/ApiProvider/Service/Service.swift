//
//  Service.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func getArticles() -> AnyPublisher<ArticlesResponse, ApiError>
}

class Service: ServiceProtocol {
    
    private let apiClient: ApiClientProtocol
    private var articleRequest: AnyCancellable?
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getArticles() -> AnyPublisher<ArticlesResponse, ApiError> {
        articleRequest?.cancel()
        
        return apiClient.getArticles()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
}
