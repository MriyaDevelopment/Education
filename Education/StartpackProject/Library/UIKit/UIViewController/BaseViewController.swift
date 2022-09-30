//
//  BaseViewController.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import SnapKit
import FloatingPanel

class BaseViewController<View: UIView>: UIViewController, UIGestureRecognizerDelegate, FloatingPanelControllerDelegate {
    
    var showErrorAlertView: TwoStringClosure?
    
    var showModalErrorView: TwoStringClosure?
    
    var rootView: View { view as! View }
    let navBar = NavigationBar()
    var isOnScreen: Bool = false
    private var backgroundView = UIView()
    private var loaderViewController: UIViewController?

    lazy var backActionClosure: () -> Void = { [weak self] in self?.navigationController?.popViewController(animated: true) }
    
    override func loadView() {
        view = View()
        
        view.addTapGestureToHideKeyboard()
        
        navBar.backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        if ( self != self.navigationController?.viewControllers[0] ) {
            let button = UIButton()
            let image = AppIcons.getIcon(.i_back_button_detail)
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            button.snp.makeConstraints { (make) in
                make.width.height.equalTo(24)
            }
            navBar.addItem(button, toPosition: .leftSide)
        }
    }
    
    @objc private func backAction() {
        backActionClosure()
    }
    
    func hideNavBar() {
        navBar.isHidden = true
        self.additionalSafeAreaInsets.top = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as UIGestureRecognizerDelegate
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.additionalSafeAreaInsets.top = 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isOnScreen = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isOnScreen = false
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, animatorForPresentingTo state: FloatingPanelState) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.35, curve: .easeOut)
    }

    func floatingPanel(_ fpc: FloatingPanelController, animatorForDismissingWith velocity: CGVector) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: 0.35, curve: .easeOut)
    }
}
