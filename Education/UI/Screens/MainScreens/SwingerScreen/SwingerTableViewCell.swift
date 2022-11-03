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
    private var isLiked = false
    
    ///12345
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.regular(size: 16)
        label.textColor = BaseColor.hex_F1F1F1.uiColor()
        label.text = "Лигатурная игла Купера"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var instrumentImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 45
        image.layer.borderWidth = 2.0
        image.backgroundColor = .clear
        image.layer.borderColor = UIColor.white.cgColor
       // image.image = AppIcons.getIcon(.i_default_image)
        image.clipsToBounds = true
        return image
    }()
    
    private var likeButton: UIButton = {
        let button = UIButton()
        //button.setImage(AppIcons.getIcon(.i_like_disable), for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .white
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.cornerRadius = 16
        return button
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = BaseColor.hex_F1F1F1.uiColor()
        return view
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 14)
        label.textColor = BaseColor.hex_F1F1F1.uiColor()
        label.text = "Хирургический инструмент для проведения шовного материала под кровеносные сосуды. Очень длинный текст очень длинный текст  очень длинный текст  очень длинный текст тттт"
        label.numberOfLines = 3
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addElements()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(data: MainStruct){
        titleLabel.text = data.subtitleText.firstCapitalized
        instrumentImageView.image = data.backgroundImage
//        descriptionLabel.text = data.full_text
//        isLiked = data.is_liked ?? false
        
        
        
        if isLiked == true {
           // likeButton.setImage(AppIcons.getIcon(.i_like_enable), for: .normal)
        } else {
           // likeButton.setImage(AppIcons.getIcon(.i_like_disable), for: .normal)
        }
    }
   
    private func addElements() {
        
        addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(instrumentImageView)
        backView.addSubview(likeButton)
        backView.addSubview(lineView)
        backView.addSubview(descriptionLabel)
        
        makeConstraints()
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
        
        instrumentImageView.snp.makeConstraints{ (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
          
            make.height.width.equalTo(90)
        }
        
        lineView.snp.makeConstraints{ (make) in
            make.left.equalTo(instrumentImageView.snp.right).offset(10)
        
            make.top.equalTo(instrumentImageView.snp.top).offset(15)
            make.bottom.equalTo(instrumentImageView.snp.bottom).inset(15)
            make.width.equalTo(2)
        }
        
        descriptionLabel.snp.makeConstraints{ (make) in
            make.left.equalTo(lineView).offset(10)
            make.right.equalToSuperview().inset(40)
            make.top.equalTo(lineView.snp.top)
            make.bottom.equalTo(lineView.snp.bottom)
        }
        
    }
    
    func addTarget() {
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    }
    
    @objc private func likeAction() {
        if isLiked == true {
           // likeButton.setImage(AppIcons.getIcon(.i_like_disable), for: .normal)
            isLiked = false
            likeDisableClicked?()
        } else {
          //  likeButton.setImage(AppIcons.getIcon(.i_like_enable), for: .normal)
            isLiked = true
            likeEnableClicked?()
        }
       
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
