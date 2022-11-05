//
//  MainView.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

final class DetailView: UIView {
     
  

    
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
      
  
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.medium(size: 14)
        label.textColor = .red
        label.text = "khouhkojn"
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
    
    func configure(model: MainStruct) {
        label.text = model.titleText
        imageView.image = model.backgroundImage
        descriptionLabel.text = model.descriptionText
    }
    
    
    
    
    private func addElements() {
        addSubview(label)
        addSubview(imageView)
        addSubview(descriptionLabel)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
      
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(130)
            make.top.equalTo(imageView.snp.bottom).offset(50)
            
        }
    }
    
}
