//
//  Provider.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

// Есть метод .receive - он означает в каком потоке (потоков бывает множествао, есть главный поток, есть глобал поток + можно насоздавать много кастомных потоков)

//RunLoop.main - просто ЮАЙ поток
// .sink - сюда сливаются даннные которые мы плучаем с бэка
// кейс .failure - если пришел от комбайна фейлур, это означает что ошибка сети (как правило)

import Foundation
import Combine

protocol ProviderProtocol {
    
    var events: PassthroughSubject<ProviderEvent, Never> { get }
    var stateArticles: CurrentValueSubject<ArticlesState, Never> { get }


    func getCharacters()
}

final class ProviderImpl: ProviderProtocol {
    
    let events = PassthroughSubject<ProviderEvent, Never>()
    let stateArticles = CurrentValueSubject<ArticlesState, Never>(ArticlesState.inital)
    
    private let service: ServiceProtocol
    private var articleRequest: AnyCancellable?
        
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func getCharacters() {
        articleRequest?.cancel()
        
        articleRequest = service.getCharacters()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
   
                self.stateArticles.value = self.stateArticles.value
                       .with(articlesResponse: result.results)
                self.events.send(.getCharactersSuccess(result))
              
               
            })
    }
}

enum ProviderEvent {
    case error(_ error: ApiError)
    case errorMessage(_ errorMessage: String?)
    case getCharactersSuccess(_ response: CharacterResponse)
}

struct ArticlesState {
    var articlesResponse: [Result]?
    
    static let inital = ArticlesState(
        articlesResponse: nil
    )
    
    func with(articlesResponse: [Result]?) -> Self {
        ArticlesState(
            articlesResponse: articlesResponse
        )
    }
}
