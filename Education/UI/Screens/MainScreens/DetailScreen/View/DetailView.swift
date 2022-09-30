//
//  MainView.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

final class DetailView: UIView {
    

    private let label: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 24)
        label.textAlignment = .center
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
    
    func configure(model: MainModel) {
        label.text = "Education = \(model.id) \(model.title) \(model.subtitle)"
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
