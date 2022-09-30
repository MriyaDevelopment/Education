//
//  RouterProtocol.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import FloatingPanel
import Foundation

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}

protocol RouterProtocol: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, animated: Bool, guide: UILayoutGuide)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, hideBottomBar: Bool)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
    
}

final class Router: RouterProtocol {
    
    private var fpc: FloatingPanelController?
    private var fpcLayout: FloatingPanelLayout?
    private var guide: UILayoutGuide?
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        fpc?.invalidateLayout()
        guard let guide = guide else { return }
        fpc?.layout = FloatingLayout(guide: guide, heightKeyboard: keyboardHeight)
        fpc?.move(to: .full, animated: true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        fpc?.invalidateLayout()
        guard let guide = guide else { return }
        fpc?.layout = FloatingLayout(guide: guide, heightKeyboard: 0)
        fpc?.move(to: .half, animated: true)
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func present(_ module: Presentable?, animated: Bool, guide: UILayoutGuide) {
        guard let controller = module?.toPresent() else { return }
        let bottomSheet = setBottomSheet(guide: guide, controller: controller)
        rootController?.present(bottomSheet, animated: true, completion: nil)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, hideBottomBar: Bool) {
        push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent(),
            (controller is UINavigationController == false)
        else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    private func setBottomSheet(guide: UILayoutGuide, controller: UIViewController) -> FloatingPanelController {
        fpc = FloatingPanelController()
        fpcLayout = FloatingLayout(guide: guide, heightKeyboard: 0)
        self.guide = guide
        guard let fpc = fpc,
              let fpcLayout = fpcLayout else { return FloatingPanelController() }
        fpc.layout = fpcLayout
        fpc.surfaceView.grabberHandlePadding = 15.0
        fpc.surfaceView.grabberHandleSize = .init(width: 155.0, height: 5.0)
        fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        fpc.isRemovalInteractionEnabled = true
        fpc.delegate = controller as? FloatingPanelControllerDelegate
        fpc.set(contentViewController: controller)
        fpc.surfaceView.layer.cornerRadius = 20
        fpc.surfaceView.clipsToBounds = true
        return fpc
    }
}
