//
//  LoginViewController.swift
//  Education
//
//  Created by Илья Кузнецов on 05.10.2022.
//

import UIKit
import Combine

final class LoginViewController<View: LoginScreenView>: BaseViewController<View> {
        
    var buttonClicked: ModelClosure?
    private var cancalables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subscribeForUpdates() {
        rootView.events.sink { [weak self] in self?.onViewEvents($0) }.store(in: &cancalables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForUpdates()
        navBar.hideView()
    }
    private func onViewEvents(_ event: MainScreenViewEvents) {
        switch event {
        case .buttonClicked(let model):
            buttonClicked?(model)
        case .cellClicked(_):
            break
        }
    }
    
   
}
