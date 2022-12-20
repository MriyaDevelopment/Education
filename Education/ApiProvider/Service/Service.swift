//
//  Service.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

//Service - отвечает за обработку ошибок API. Промежуточный слой. Ничего делать не надо просто повторять по подобию.
// eraseToAnyPublisher() - чисто реактивная история, даёт возможность подписаться на изменения (приход данных с бэка)

import Foundation
import Combine

protocol ServiceProtocol {
    func getCharacters() -> AnyPublisher<CharacterResponse, ApiError>
}

class Service: ServiceProtocol {
    
    private let apiClient: ApiClientProtocol
    private var articleRequest: AnyCancellable?
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getCharacters() -> AnyPublisher<CharacterResponse, ApiError> {
        articleRequest?.cancel()
        
        return apiClient.getCharacters()
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
    
}
