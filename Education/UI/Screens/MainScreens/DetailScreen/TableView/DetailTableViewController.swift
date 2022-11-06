//
//  DetailTableViewController.swift
//  Education
//
//  Created by Роман Приладных on 14.10.2022.
//

import UIKit
import Combine
import Foundation

final class DetailTableViewController<View: DetailTableView>: BaseViewController<View> {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    
}
