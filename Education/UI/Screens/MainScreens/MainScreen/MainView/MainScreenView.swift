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
    
    private var elements: [MainStruct] = []

    
 
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
    
    lazy private var mainCollectionView: UICollectionView = {
        let layout = gridLayout
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
       
        collectionView.register(MainCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
  
        collectionView.alwaysBounceVertical = true

        return collectionView
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
        contentView.addSubview(mainCollectionView)

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
        
        mainCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
        
            make.bottom.equalToSuperview()
            
        }

    }
    
   

    func configure(elements: [MainStruct]) {
        self.elements = elements
        print("Запуск \(elements.count)")
        mainCollectionView.reloadData()
    }
    
}

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionReusableCell(withType: MainCollectionViewCell.self, for: indexPath)
        cell.configure(item: elements[indexPath.row])
        cell.clickAction = { [weak self] in
            if let model = self?.elements[indexPath.row] {
                self?.events.send(.buttonClicked(model))
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        events.send(.cellClicked(elements[indexPath.row]))
       }
}

