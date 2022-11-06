//
//  DetailTabelView.swift
//  Education
//
//  Created by Роман Приладных on 14.10.2022.
//

import UIKit
import Combine

final class DetailTableView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()

        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: MainStruct) {
//        label.text = model.titleText
        
        imageView.image = model.backgroundImage
        print("Запуск пизды с таблицы \(model.subtitleText)")
    }
    
    
    
    
    private func addElements() {
//        addSubview(label)
        addSubview(imageView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
//        label.snp.makeConstraints { make in
//            make.centerY.centerX.equalToSuperview()
//        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
    
    }
    
}

    
    
    
    
    
    
    

