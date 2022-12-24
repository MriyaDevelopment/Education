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
    func getLocations() -> AnyPublisher<LocationResponse, ApiError>
    func getCharacters() -> AnyPublisher<CharacterResponse, ApiError>
}

class Service: ServiceProtocol {
    
    private let apiClient: ApiClientProtocol
    private var locationRequest: AnyCancellable?
    
    private var charactersRequest: AnyCancellable?
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getCharacters() -> AnyPublisher<CharacterResponse, ApiError> {
        charactersRequest?.cancel()
            
            return apiClient.getCharacters()
                .mapError { error in
                    if let error = error as? ApiError {
                        return error
                    }
                    return ApiError.unknown
                }
                .eraseToAnyPublisher()
        }
    
    func getLocations() -> AnyPublisher<LocationResponse, ApiError> {
        locationRequest?.cancel()
            
            return apiClient.getLocations()
                .mapError { error in
                    if let error = error as? ApiError {
                        return error
                    }
                    return ApiError.unknown
                }
                .eraseToAnyPublisher()
        }
    
    
}
