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
    //Вопрос - зачем тут buttonClicked
    private func showMainScreen() {
        let screen = screenFactory.makeLoginScreen()
        screen.buttonClicked = { [weak self] model in
            self?.showDetailScreen(model: model)
        }
        router.setRootModule(screen, hideBar: true)
    }
    
    private func showDetailScreen(model: MainModel) {
        let screen = screenFactory.makeDetailScreen(model: model)
        router.present(screen, animated: true, guide: screen.guide)
    }
}
