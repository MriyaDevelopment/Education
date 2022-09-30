//
//  MainScreenView.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

final class MainView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Education"
        label.font = MainFont.bold(size: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()

        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(label)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
}
