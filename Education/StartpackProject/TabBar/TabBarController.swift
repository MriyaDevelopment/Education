//
//  TabBarController.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//

import Foundation

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = BaseColor.hex_FFFFFF.uiColor()
        UITabBar.appearance().barTintColor = BaseColor.hex_FFFFFF.uiColor()
        self.tabBar.clipsToBounds = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBar.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        self.tabBar.layer.borderColor = BaseColor.hex_ADAEB2.cgColor()
        self.tabBar.layer.borderWidth = 1
    }
    
    private func setAppearance() {

        let font = UIFont.boldSystemFont(ofSize: 11)

        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: font ],
            for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: font ],
            for: .selected)

        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: BaseColor.hex_E73626.uiColor()],
            for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: BaseColor.hex_A5A7AD.uiColor()],
            for: .selected)
    }
}


extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
           guard let barItemView = item.value(forKey: "view") as? UIView else { return }

           let timeInterval: TimeInterval = 0.3
           let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
               barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
           }
           propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
           propertyAnimator.startAnimation()
       }
    
    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
          return TabBarAnimatedTransitioning()
      }
}
