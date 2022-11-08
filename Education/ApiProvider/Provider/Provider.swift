//
//  Provider.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import Foundation
import Combine

protocol ProviderProtocol {
    
    var events: PassthroughSubject<ProviderEvent, Never> { get }
    var stateArticles: CurrentValueSubject<ArticlesState, Never> { get }


    func getArticles()
}

final class ProviderImpl: ProviderProtocol {
    
    let events = PassthroughSubject<ProviderEvent, Never>()
    let stateArticles = CurrentValueSubject<ArticlesState, Never>(ArticlesState.inital)
    
    private let service: ServiceProtocol
    private var articleRequest: AnyCancellable?
        
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func getArticles() {
        articleRequest?.cancel()
        
        articleRequest = service.getArticles()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                self.stateArticles.value = self.stateArticles.value
                    .with(articlesResponse: result.results)
                self.events.send(.getArticlesSuccess(result))
            })
    }
}

enum ProviderEvent {
    case error(_ error: ApiError)
    case errorMessage(_ errorMessage: String?)
    case getArticlesSuccess(_ response: LocationResponse)
}

struct ArticlesState {
    var articlesResponse: [Location]?
    
    static let inital = ArticlesState(
        articlesResponse: nil
    )
    
    func with(articlesResponse: [Location]?) -> Self {
        ArticlesState(
            articlesResponse: articlesResponse
        )
    }
}
