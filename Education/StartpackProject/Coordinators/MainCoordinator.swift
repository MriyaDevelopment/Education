//
//  MainCoordinator.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import Foundation

final class CharactersCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    private let switchToProfileTab: VoidClosure
    
    init(router: RouterProtocol, screenFactory: ScreenFactoryProtocol, switchToProfileTab: @escaping VoidClosure) {
        self.screenFactory = screenFactory
        self.router = router
        self.switchToProfileTab = switchToProfileTab
    }
    
    override func start() {
        showMainScreen()
   
    }
    private func showMainScreen() {
    
//        screen.buttonClicked = { [weak self] model in
//            self?.showDetailScreen(model: model)
//        }
        let screen = screenFactory.makeCharactersScreen()
        screen.buttonClicked = { [weak self] model in
            self?.showDetailScreen(model: model)
        }
        router.setRootModule(screen, hideBar: true)
    }
    
    
    private func showDetailScreen(model: Result) {
        let screen = screenFactory.makeDetailScreen(model: model)
        router.push(screen, animated: true)
      
    }
    
    private func showSwingerList() {
       

    }
     
    private func showDetailScreen2(model: Result) {
//        let screen = screenFactory.makeDetailTableScreen(model: model)
//        router.push(screen, animated: true)
        
    }
    private func showFreeScreen() {
        let screen = screenFactory.makeFreeScreen()
        router.push(screen, animated: true)
        
    }
        
}
    
    
    

