//
//  SwingerListViewController.swift
//  Education
//
//  Created by Роман Приладных on 03.11.2022.
//

import UIKit
import Combine

final class SwingerListViewController<View: SwingerListView>: BaseViewController<View> {
    
    var buttonClicked: ModelClosure?
    var button: ModelClosure?
    var cellClicked: ModelClosure?
   
    private var cancalables = Set<AnyCancellable>()
    private var elements: [MainStruct] = []
    
    
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
        elements = MainStruct.placeholderItems
        rootView.configure(elements: elements)
        subscribeForUpdates()
        
    }
    
    
    
    private func onViewEvents(_ event: MainScreenViewEvents) {
        switch event {
        case .buttonClicked(let model):
            buttonClicked?(model)
        case .cellClicked(let model):
            cellClicked?(model)
            
        }
    }
    

    
}



