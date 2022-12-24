//
//  LocationViewController.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//

import UIKit
import Combine
import SwiftUI

final class LocationViewController<View: LocationView>: BaseViewController<View> {
    
    var buttonClicked: ModelClosure?
    var cellClicked: ModelClosure?
    
    var switchToEpisode: VoidClosure?
    
    private var provider: ProviderProtocol
   
    private var cancalables = Set<AnyCancellable>()
        
    init(provider: ProviderProtocol) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
        provider.events.sink { [weak self] in self?.onProviderEvents($0) }.store(in: &cancalables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Косяк - возможно не так цвет фона выставляю
        view.backgroundColor = BaseColor.hex_000000.uiColor()
        hideNavBar()
        provider.getLocations()
        subscribeForUpdates()
    }
    
    private func onViewEvents(_ event: MainScreenViewEvents) {
        switch event {
        case .buttonClicked(let model):
            buttonClicked?(model)
        case .cellClicked(let model):
            cellClicked?(model)
            
        }
    }
    
    private func onProviderEvents(_ event: ProviderEvent) {
        switch event {
        case .getLocationSuccess(_):
            guard let locations = provider.stateLocations.value.locationResponse else { return }
            rootView.configure(elements: locations)
            //switchToEpisode?()
            
        case .errorMessage(let error):
            break
        default:
            break
        }
    }
}


