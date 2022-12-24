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
    var stateLocations: CurrentValueSubject<LocationsState, Never> { get }
    var stateCharacters: CurrentValueSubject<CharacterState, Never> { get }


    func getLocations()
    func getCharacters()
}

final class ProviderImpl: ProviderProtocol {
    
    let events = PassthroughSubject<ProviderEvent, Never>()
    let stateLocations = CurrentValueSubject<LocationsState, Never>(LocationsState.inital)
    let stateCharacters = CurrentValueSubject<CharacterState, Never>(CharacterState.inital)
    
    private let service: ServiceProtocol
    private var locationRequest: AnyCancellable?
    private var episodesRequest: AnyCancellable?
    private var heroesRequest: AnyCancellable?
        
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func getLocations() {
        locationRequest?.cancel()
        
        locationRequest = service.getLocations()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                self.stateLocations.value = self.stateLocations.value
                    .with(locationResponse: result.results)
                self.events.send(.getLocationSuccess(result))
   
                self.stateLocations.value = self.stateLocations.value
                       .with(locationResponse: result.results)
                self.events.send(.getLocationSuccess(result))
              
               
            })
    }
    func getCharacters() {
        heroesRequest?.cancel()
        
        heroesRequest = service.getCharacters()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self = self, case .failure(let error) = result else { return }
                self.events.send(.error(error))
                
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                self.stateCharacters.value = self.stateCharacters.value
                    .with(charactersResponse: result.results)
                self.events.send(.getCharactersSuccess(result))
   
                self.stateCharacters.value = self.stateCharacters.value
                       .with(charactersResponse: result.results)
                self.events.send(.getCharactersSuccess(result))
              
               
            })
    }
}

enum ProviderEvent {
    case error(_ error: ApiError)
    case errorMessage(_ errorMessage: String?)
    case getLocationSuccess(_ response: LocationResponse)
    case getCharactersSuccess(_ response: CharacterResponse)
    //case getHeroesSuccess()
    //case getEpisodesSuccess()
}

struct LocationsState {
    var locationResponse: [Location]?
    
    static let inital = LocationsState(
        locationResponse: nil
    )
    
    func with(locationResponse: [Location]?) -> Self {
        LocationsState(
            locationResponse: locationResponse
        )
    }
}

struct CharacterState {
    var charactersResponse: [Result]?
    
    static let inital = CharacterState(
        charactersResponse: nil
    )
    
    func with(charactersResponse: [Result]?) -> Self {
        CharacterState(
            charactersResponse: charactersResponse
        )
    }
}

