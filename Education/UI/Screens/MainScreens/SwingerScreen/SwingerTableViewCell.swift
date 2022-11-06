//
//  InstrumentTableViewCell.swift
//  MedicalInstruments
//
//  Created by Mac Pro on 10.03.2022.
//

import UIKit
import Combine

final class SwingerTableViewCell: UITableViewCell {
    
    var likeEnableClicked: VoidClosure?
    var likeDisableClicked: VoidClosure?
    var clickAction: VoidClosure?
    
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isUserInteractionEnabled = true
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 10)
        label.textColor = BaseColor.hex_F1F1F1.uiColor()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var ImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 45
        image.layer.borderWidth = 2.0
        image.backgroundColor = .clear
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_F1F1F1.uiColor()
        return view
    }()
    
//    private var descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.font = MainFont.medium(size: 14)
//        label.textColor = BaseColor.hex_F1F1F1.uiColor()
//        label.text = "Интерстеллар лучший фильм про космос"
//        label.numberOfLines = 3
//        return label
//    }()
    
    private var tableButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 2.0
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 15.0
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        return button
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(data: MainStruct){
        titleLabel.text = data.subtitleText
        ImageView.image = data.backgroundImage
        tableButton.setTitle(data.descriptionText, for: .normal)
        
    }
   
    private func addElements() {
        
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(ImageView)
        backView.addSubview(lineView)
        backView.addSubview(tableButton)
        makeConstraints()
        addTargets()
    }
    
    
    private func addTargets () {
        tableButton.addTarget(self, action: #selector(clickedAction), for: .touchUpInside)
      
    }
    
    @objc private func clickedAction() {
        clickAction?()
        print("Нажатие кнопки")
    }
    
   
    
    private func makeConstraints() {
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(101)
            make.bottom.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        ImageView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
          
            make.height.width.equalTo(90)
        }
        
        lineView.snp.makeConstraints{ (make) in
            make.left.equalTo(ImageView.snp.right).offset(10)
            make.top.equalTo(ImageView.snp.top).offset(15)
            make.bottom.equalTo(ImageView.snp.bottom).inset(15)
            make.width.equalTo(2)
        }
        
        tableButton.snp.makeConstraints{ (make) in
            make.left.equalTo(lineView).offset(15)
            make.right.equalToSuperview().inset(30)
            make.top.equalTo(lineView.snp.top)
            make.bottom.equalTo(lineView.snp.bottom)
        }
        
      }
    
    }

