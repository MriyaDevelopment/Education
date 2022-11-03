//
//  MainView.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

final class DetailView: UIView {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.brown
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 24)
        label.textAlignment = .center
        return label
    }()
    private let labelOne: UILabel = {
        let labelOne = UILabel()
        labelOne.font = MainFont.bold(size: 24)
        labelOne.backgroundColor = .red
        labelOne.textAlignment = .center
        return labelOne
    }()
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    var guide: UILayoutGuide
    
    
    override init(frame: CGRect) {
        guide = scrollView.contentLayoutGuide
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: MainModel) {
        label.text = "Education = \(model.id) \(model.title) \(model.subtitle)"
        labelOne.text = "Кунилингус"
    }
    
    private func addElements() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(labelOne)
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
           
        }
        labelOne.snp.makeConstraints { make in
            make.top.equalTo(label.snp_bottom)
            make.bottom.equalToSuperview().inset(50)
            make.left.right.equalTo(label).offset(10)
//            make.height.equalTo(200)
            
        }
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            //В примере этого не было, но без него скролл нихуя не работал
            make.width.equalToSuperview()
        }
    }
    
}
