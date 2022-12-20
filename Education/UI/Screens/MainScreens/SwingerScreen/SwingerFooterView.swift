//
//  SwingerFooterView.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//

import Foundation
import UIKit


class SwingerFooterView: UIView {
    
    private var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .white
        return indicatorView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        indicatorView.startAnimating()
        addElements()
        
    }
    func addElements(){
        addSubview(indicatorView)
        makeConstraints()
        
    }
    private func makeConstraints() {
      
        indicatorView.snp.makeConstraints { (make) in
            //make.height.width.equalTo(40)
            make.leading.equalToSuperview().offset(100)
            make.top.equalToSuperview().offset(25)
            
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
