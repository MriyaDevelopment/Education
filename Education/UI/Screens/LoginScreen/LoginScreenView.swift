//
//  MainScreenView.swift
//  Education
//
//  Created by Илья Кузнецов on 05.10.2022.
//

import UIKit
import Combine

final class LoginScreenView: UIView {
    
    let events = PassthroughSubject<MainScreenViewEvents, Never>()

    private let imageLogo: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "logo")
        return imageLogo
    }()
    
    var emailInputForm: InputForm = {
        let view = InputForm(type: .email, topTitleText: "Email", placeholder: "Введите ваш email")
        return view
    }()
    
    var passwordInputForm: InputForm = {
        let view = InputForm(type: .password, topTitleText: "Пароль", placeholder: "Введите ваш пароль")
        return view
    }()
    
    private let buttonNext: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = MainFont.regular(size: 16)
        
        button.backgroundColor = UIColor(named: "millenium_blue")
        button.layer.cornerRadius = 4.0
        button.setTitleColor(BaseColor.hex_FFFFFF.uiColor(), for: .normal)
        return button
    }()
    
    private let buttonForget: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = MainFont.regular(size: 16)
        button.setTitleColor(UIColor.black, for: .normal)
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
        addSubview(imageLogo)
        addSubview(emailInputForm)
        addSubview(passwordInputForm)
        addSubview(buttonNext)
        addSubview(buttonForget)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        imageLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(155)
            make.width.equalTo(260)
            make.height.equalTo(78)
        }
        
        emailInputForm.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageLogo.snp.bottom).offset(60)
            make.right.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
        }
        passwordInputForm.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailInputForm.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
        }
        
        buttonNext.snp.makeConstraints { make in
            make.top.equalTo(passwordInputForm.snp.bottom).offset(25)
            make.right.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        buttonForget.snp.makeConstraints { make in
            make.top.equalTo(buttonNext.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func addTargets() {
        buttonNext.addTarget(self, action: #selector(clickedAction), for: .touchUpInside)
    }
    
    @objc private func clickedAction() {
        let model = MainStruct(id: 0, backgroundImage: UIImage(), type: "123", titleText: "123", subtitleText: "13")
        events.send(.buttonClicked(model))
    }
    
}

