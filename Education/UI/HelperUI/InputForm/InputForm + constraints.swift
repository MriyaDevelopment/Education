//
//  InputForm + constraints.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

extension InputForm {
    func addElements() {
        
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(backView)
        mainStackView.addArrangedSubview(separatorView)
        //mainStackView.addArrangedSubview(bottomErrorLabel)
        backView.addSubview(inputStackView)
                
        containerView.addSubview(textField)
        containerView.addSubview(titleLabel)
        containerView.addSubview(leftImage)
        containerView.addSubview(rightImage)

        inputStackView.addArrangedSubview(containerView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
//        topLabel.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalToSuperview()
//        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        backView.snp.makeConstraints { (make) in
            make.height.equalTo(35)
        }
        
        inputStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(leftImage.snp.right).offset(1)
            make.right.equalTo(rightImage.snp.left).offset(1)
            make.centerY.equalToSuperview()
        }
        
        leftImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(15)
        }
        
        rightImage.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImage.snp.right).offset(10)
            make.right.equalTo(rightImage.snp.left).offset(-5)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
        }
    }
}
