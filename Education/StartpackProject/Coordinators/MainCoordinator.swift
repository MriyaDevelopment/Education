//
//  MainCoordinator.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showMainScreen()
    }
    
    private func showMainScreen() {
        let screen = screenFactory.makeMainScreen()
        screen.buttonClicked = { [weak self] model in
            self?.showDetailScreen(model: model)
        }
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showDetailScreen(model: MainStruct) {
        let screen = screenFactory.makeDetailScreen(model: model)
        router.push(screen, animated: true)
    }
}


