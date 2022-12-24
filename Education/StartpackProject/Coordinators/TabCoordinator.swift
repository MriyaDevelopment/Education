//
//  TabCoordinator.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//

import Foundation

import UIKit


final class TabCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    
    private let screenFactory: ScreenFactoryProtocol
    private let router: RouterProtocol
    private let tabBarController: UITabBarController
    
//MARK: Uncomment this closures when need to transfer through tabs in tabbar

    lazy var switchToChallengesTab = ({
        self.tabBarController.selectedIndex = 1
    })
//
//    lazy var switchToFavouritesTab = ({
//        self.tabBarController.selectedIndex = 2
//    })
//
    lazy var switchToEpisodes = ({
        self.tabBarController.selectedIndex = 1
    })
    lazy var switchToCharacters = ({
        self.tabBarController.selectedIndex = 2
    })
    
    init(tabBarController: UITabBarController, router: RouterProtocol, screenFactory: ScreenFactoryProtocol ) {
        self.tabBarController = tabBarController
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        
        let selectedItemTitle: [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.foregroundColor: BaseColor.hex_06C149.uiColor(),
             NSAttributedString.Key.font: MainFont.semiBold(size: 12)]
        
        let unselectedItemTitle: [NSAttributedString.Key : Any] =
            [NSAttributedString.Key.foregroundColor: BaseColor.hex_F1F1F1.uiColor(),
             NSAttributedString.Key.font: MainFont.semiBold(size: 12)]
        
        //MARK: Locations
        let locationsNavigationController = UINavigationController()
        let locationBarItem = UITabBarItem(title: titlesTabBarItem.location.rawValue,
                                       image: AppIcons.getIcon(.i_email_icon),
                                       selectedImage: AppIcons.getIcon(.i_eye_image).setColor(BaseColor.hex_06C149.uiColor()))
        locationsNavigationController.tabBarItem = locationBarItem
        let locationRouter = Router(rootController: locationsNavigationController)
        let locationCoordinator = LocationCoordinator(router: locationRouter, screenFactory: screenFactory, switchToProfileTab: switchToEpisodes)
        
        locationBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
        locationBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
        
        
        
        
        //MARK: Locations
        let charactersNavigationController = UINavigationController()
        let charactersBarItem = UITabBarItem(title: titlesTabBarItem.location.rawValue,
                                       image: AppIcons.getIcon(.i_email_icon),
                                       selectedImage: AppIcons.getIcon(.i_eye_image).setColor(BaseColor.hex_06C149.uiColor()))
        charactersNavigationController.tabBarItem = charactersBarItem
        let charactersRouter = Router(rootController: charactersNavigationController)
        let charactersCoordinator = CharactersCoordinator(router: charactersRouter, screenFactory: screenFactory, switchToProfileTab: switchToCharacters)
        
        charactersBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
        charactersBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
        
        //MARK: Challenges
//        let challengesNavigationController = UINavigationController()
//        let challengesBarItem = UITabBarItem(title: titlesTabBarItem.catalog.rawValue,
//                                        image: AppIcons.getIcon(.i_challenges),
//                                        selectedImage: AppIcons.getIcon(.i_challenges_eneble))
//        challengesNavigationController.tabBarItem = challengesBarItem
//        let challengesRouter = Router(rootController: challengesNavigationController)
//        let challengesCoordinator = ChallengesCoordinator(router: challengesRouter, screenFactory: screenFactory, switchToProfileTab: switchToProfileTab)
//
//        challengesBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
//        challengesBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
//
//
        //MARK: Favourites
//        let favouritesNavigationController = UINavigationController()
//        let favouritesBarItem = UITabBarItem(title: titlesTabBarItem.service.rawValue,
//                                       image: AppIcons.getIcon(.i_favourites),
//                                       selectedImage: AppIcons.getIcon(.i_favourites).setColor(BaseColor.hex_5B67CA.uiColor()))
//        favouritesNavigationController.tabBarItem = favouritesBarItem
//        let favouritesRouter = Router(rootController: favouritesNavigationController)
//        let favouritesCoordinator = FavouritesCoordinator(router: favouritesRouter, screenFactory: screenFactory)
//
//        favouritesBarItem.setTitleTextAttributes(unselectedItemTitle, for: .normal)
//        favouritesBarItem.setTitleTextAttributes(selectedItemTitle, for: .selected)
        
        //MARK: Profile
        
        
        tabBarController.viewControllers = [
            locationsNavigationController,
            charactersNavigationController
        ]
        
        //Косяк - не знаю зачем тогда цвета на 73 и 58 выставлять
        tabBarController.tabBar.tintColor = BaseColor.hex_06C149.uiColor()
        
        tabBarController.modalPresentationStyle = .fullScreen
        router.present(tabBarController, animated: false)
        
        locationCoordinator.start()
        charactersCoordinator.start()
//        favouritesCoordinator.start()
       
        self.addDependency(locationCoordinator)
        self.addDependency(charactersCoordinator)
//        self.addDependency(challengesCoordinator)
//        self.addDependency(favouritesCoordinator)
        
        tabBarController.selectedIndex = 0
    }
    
    enum titlesTabBarItem: String {
        case location = "Locations"
        case catalog = "Испытания"
        case service = "Избранное"
        case profile = "Профиль"
    }

}
