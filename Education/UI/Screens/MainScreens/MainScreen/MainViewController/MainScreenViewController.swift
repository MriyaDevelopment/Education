//
//  MainScreenViewController.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import Combine

final class MainViewController<View: MainView>: BaseViewController<View> {
    
    var buttonClicked: ModelClosure?
    var cellClicked: ModelClosure?
    
    private var provider: ProviderProtocol
   
    private var cancalables = Set<AnyCancellable>()
    private var elements: [MainStruct] = []
    
    
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
        provider.getArticles()
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
        case .getArticlesSuccess(let response):
            guard let articles = response.articles else { return }
            rootView.configure(elements: articles)
        case .errorMessage(let error):
            break
        default:
            break
        }
    }
}


