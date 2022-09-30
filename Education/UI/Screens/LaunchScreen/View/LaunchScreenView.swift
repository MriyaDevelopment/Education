//
//  LaunchScreenView.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

final class LaunchScreenView: UIView {
        
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = AppIcons.getIcon(.i_heart_input)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_1B1919.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(backgroundImage)
        makeConstraints()
    }
    
    private func makeConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
}
