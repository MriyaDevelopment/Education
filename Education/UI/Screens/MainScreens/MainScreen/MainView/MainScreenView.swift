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

    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
   // private var elements: [Location] = []

    
 
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 20)
        label.text = "Восемь планет солнечной системы"
        label.textAlignment = .center
        return label
    }()
    
  
   
    
    private lazy var gridLayout: UICollectionViewFlowLayout = {
        
        let numberOfItemsInRow: CGFloat = 2
        
        let sidesOffset: CGFloat = 10
        let minimumInteritemSpacing: CGFloat = 10
        
        let cellWidth: CGFloat = (UIScreen.main.bounds.width - sidesOffset*2 - minimumInteritemSpacing*(numberOfItemsInRow-1)) / numberOfItemsInRow
        let cellHeight: CGFloat = 125 //UIScreen.main.bounds.height == 568 ? 332 : cellWidth * 332 / 168
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: sidesOffset, bottom: 10, right: sidesOffset)
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = 30
        return layout
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {

        addSubview(contentView)
        contentView.addSubview(subTitleLabel)

        makeConstraints()
    }

    private func makeConstraints() {

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(21)
            make.right.equalToSuperview().inset(16)
            make.left.top.equalToSuperview().inset(15)
        }

    }

    func configure(elements: [Location]) {
       
    }
    
}

