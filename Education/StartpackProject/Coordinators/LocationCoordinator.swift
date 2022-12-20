//
//  LocationCoordinator.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//

import Foundation

final class LocationCoordinator: BaseCoordinator {
    
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
        let screen = screenFactory.makeLocationScreen()
        screen.buttonClicked = { [weak self] model in
            self?.showDetailScreen(model: model)
        }
        screen.switchToEpisode = { [weak self] in
            self?.switchToProfileTab()
            
        }
        router.setRootModule(screen, hideBar: true)
    }
    
    
    private func showDetailScreen(model: MainStruct) {
        let screen = screenFactory.makeDetailScreen(model: model)
        router.push(screen, animated: true)
      
    }
    
    private func showSwingerList() {
        let screen = screenFactory.makeSwingerScreen()
        router.push(screen, animated: true)
      
        router.push(screen, animated: true)

    }
     
    private func showDetailScreen2(model: MainStruct) {
//        let screen = screenFactory.makeDetailTableScreen(model: model)
//        router.push(screen, animated: true)
        
    }
    private func showFreeScreen() {
        let screen = screenFactory.makeFreeScreen()
        router.push(screen, animated: true)
        
    }
        
}
