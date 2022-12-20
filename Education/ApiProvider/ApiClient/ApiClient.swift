//
//  ApiClient.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import Foundation
import Combine

protocol ApiClientProtocol {
    func getLocations() -> AnyPublisher<LocationResponse, Error>
}

private func getPath(for method: String) -> String {
    return "/api/\(method)"
}

extension ApiClient: ApiClientProtocol {
    
//MARK: GET methods
    
    func getLocations() -> AnyPublisher<LocationResponse, Error> {
        let request = requestBuilder.requestBuild(
            path: getPath(for: "location"),
            urlParametrs: [:])
        print("Запуск \(getPath(for: "location"))")
        return performRequest(request)
    }
}
