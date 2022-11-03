//
//  DetailViewController.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

final class DetailViewController<View: DetailView>: BaseViewController<View> {
    
    private var model: MainModel
    
    var guide: UILayoutGuide {
            get {
                rootView.guide
            }
        }
    
    init(model: MainModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.configure(model: model)
        navBar.showView()
        navBar.showBottomLine()
    }
    
}
