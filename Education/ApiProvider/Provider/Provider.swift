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
    var stateLocations: CurrentValueSubject<LocationsState, Never> { get }


    func getLocations()
}

final class ProviderImpl: ProviderProtocol {
    
    let events = PassthroughSubject<ProviderEvent, Never>()
    let stateLocations = CurrentValueSubject<LocationsState, Never>(LocationsState.inital)
    
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
            })
    }
}

enum ProviderEvent {
    case error(_ error: ApiError)
    case errorMessage(_ errorMessage: String?)
    case getLocationSuccess(_ response: LocationResponse)
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
