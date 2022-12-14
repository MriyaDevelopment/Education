//
//  MainCollectionViewCell.swift
//  Education
//
//  Created by Роман Приладных on 05.10.2022.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    var clickAction: VoidClosure?

    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.systemBlue
        label.numberOfLines = 2
        return label
    }()
    
    private var button: UIButton = {
        let label = UIButton()
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.layer.borderWidth = 2.0
        label.layer.cornerRadius = 10.0
        return label
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 14
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 2.0
        clipsToBounds = true
        
        addElements()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(item: Article) {
        self.titleLabel.text = item.title
        self.button.setTitle(item.type?.rawValue, for: .normal)
        self.backgroundImageView.loadArticleImage(by: item.image ?? "")
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


