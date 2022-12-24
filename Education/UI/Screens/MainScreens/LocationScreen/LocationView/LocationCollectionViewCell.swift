//
//  LocationCollectionViewCell.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//

import UIKit

final class LocationCollectionViewCell: UICollectionViewCell {
    
    var clickAction: VoidClosure?
    

    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = BaseColor.hex_06C149.uiColor()
        label.numberOfLines = 2
        return label
    }()
    
    private var button: UIButton = {
        let label = UIButton()
        label.layer.borderColor = BaseColor.hex_06C149.cgColor()
        label.layer.borderWidth = 2.0
        label.setTitleColor(BaseColor.hex_06C149.uiColor(), for: .normal)
        label.layer.cornerRadius = 10.0
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 14
        layer.borderColor = BaseColor.hex_06C149.cgColor()
        layer.borderWidth = 2.0
        clipsToBounds = true
        
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(item: Location) {
        self.titleLabel.text = item.name
        self.button.setTitle(item.type, for: .normal)
        //self.backgroundImageView.loadArticleImage(by: item.image ?? "")
    }

    
    private func addElements() {
        
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(titleLabel)
        backgroundImageView.addSubview(button)
        makeConstraints()
    
    }
    
    private func addTargets () {
        button.addTarget(self, action: #selector(clickedAction2), for: .touchUpInside)
    }
    
    @objc private func clickedAction2() {
        clickAction?()
        
    }
    
    private func makeConstraints() {
        
        backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
   
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().offset(-10)
        }
        
        button.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(12)
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(5)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
    }
}


