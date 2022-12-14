//
//  DI.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

final class Di {
    
    fileprivate let screenFactory: ScreenFactory
    fileprivate let coordinatorFactory: CoordinatorFactoryProtocol
    
    fileprivate let configuration: ConfigurationProtocol
    fileprivate let sessionConfiguration: SessionConfigurationProtocol
    
    fileprivate let requestBuilder: RequestBuilderProtocol
    fileprivate let apiClient: ApiClient
    
    fileprivate let service: ServiceProtocol
    fileprivate let provider: ProviderProtocol
    
    init() {
        
        screenFactory = ScreenFactory()
        coordinatorFactory = CoordinatorFactory(screenFactory: screenFactory)
        
        configuration = Configuration()
        sessionConfiguration = SessionConfiguration()
        
        requestBuilder = RequestBuilder(configuration: configuration)
        
        apiClient = ApiClient(requestBuilder: requestBuilder, configuration: sessionConfiguration.configuration)
        
        service = Service(apiClient: apiClient)
        provider = ProviderImpl(service: service)
        
        screenFactory.di = self
    }
    
    private func clearProviderState() {
        #warning("Set code later")
    }
}

protocol AppFactoryProtocol {
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator)
}

extension Di: AppFactoryProtocol {
    
    func makeKeyWindowWithCoordinator() -> (UIWindow, Coordinator) {
        let window = UIWindow()
        let rootVC = UINavigationController()
        let router = Router(rootController: rootVC)
        let coordinator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, coordinator)
    }
}

protocol ScreenFactoryProtocol {
        
    func makeLaunchScreen() -> LaunchScreenViewController<LaunchScreenView>
    
    func makeMainScreen() -> MainViewController<MainView>
    
    func makeDetailScreen(model: MainStruct) -> DetailViewController<DetailView>
    
    func makeFreeScreen() -> DetailTableViewController<DetailTableView>
    
    func makeSwingerScreen() -> SwingerListViewController<SwingerListView>
    
}

final class ScreenFactory: ScreenFactoryProtocol {

    fileprivate weak var di: Di!
    fileprivate init() {}
        
    func makeFreeScreen() -> DetailTableViewController<DetailTableView> {
        DetailTableViewController<DetailTableView>()
    }
    
    func makeSwingerScreen() -> SwingerListViewController<SwingerListView> {
        SwingerListViewController<SwingerListView>()
    }
    
    
    func makeLaunchScreen() -> LaunchScreenViewController<LaunchScreenView> {
        LaunchScreenViewController<LaunchScreenView>()
    }
    func makeLoginScreen() -> LoginViewController<LoginScreenView> {
        LoginViewController<LoginScreenView>()
    }
    func makeMainScreen() -> MainViewController<MainView> {
        MainViewController<MainView>(provider: di.provider)
    }
    
    func makeDetailScreen(model: MainStruct) -> DetailViewController<DetailView> {
        DetailViewController<DetailView>(model: model)
    }
    
}

protocol CoordinatorFactoryProtocol {
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator
    func makeStartCoordinator(router: RouterProtocol) -> StartCoordinator 
    func makeMainCoordinator(router: RouterProtocol) -> MainCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    private let screenFactory: ScreenFactoryProtocol
    
    fileprivate init(screenFactory: ScreenFactoryProtocol) {
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: RouterProtocol) -> ApplicationCoordinator {
        ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeStartCoordinator(router: RouterProtocol) -> StartCoordinator {
        StartCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeMainCoordinator(router: RouterProtocol) -> MainCoordinator {
        MainCoordinator(router: router, screenFactory: screenFactory)
        
    }
}
