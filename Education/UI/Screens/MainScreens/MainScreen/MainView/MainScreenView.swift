//
//  MainScreenView.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit
import Combine

final class MainView: UIView {
    
    let events = PassthroughSubject<MainScreenViewEvents, Never>()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Education"
        label.font = MainFont.bold(size: 24)
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Click me", for: .normal)
        button.titleLabel?.font = MainFont.bold(size: 20)
        button.setTitleColor(BaseColor.hex_E73626.uiColor(), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()

        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(label)
        addSubview(button)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addTargets() {
        button.addTarget(self, action: #selector(clickedAction), for: .touchUpInside)
    }
    
    @objc private func clickedAction() {
        let model = MainModel(id: 0, title: "Jopa", subtitle: "Hui")
        events.send(.buttonClicked(model))
    }
    
}
