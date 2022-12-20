//
//  Service.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import Foundation
import Combine

protocol ServiceProtocol {
    func getLocations() -> AnyPublisher<LocationResponse, ApiError>
}

class Service: ServiceProtocol {
    
    private let apiClient: ApiClientProtocol
    private var locationRequest: AnyCancellable?
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
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
