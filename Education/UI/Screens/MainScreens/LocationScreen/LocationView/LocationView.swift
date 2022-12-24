//
//  LocationView.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//



import UIKit
import Combine

final class LocationView: UIView {

    let events = PassthroughSubject<MainScreenViewEvents, Never>()
    
    private let footerView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)


    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var elements: [Location] = []

    
 
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
    
    lazy private var locationCollectionView: UICollectionView = {
        let layout = gridLayout
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LocationCollectionViewCell.self)
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
        contentView.addSubview(locationCollectionView)

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
        
        locationCollectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
        
            make.bottom.equalToSuperview()
            
        }

    }

    func configure(elements: [Location]) {
        //self.elements = elements
        self.elements.append(contentsOf: elements)
        print("Запуск \(self.elements.count)")
        locationCollectionView.reloadData()
    }
    
}

extension LocationView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionReusableCell(withType: LocationCollectionViewCell.self, for: indexPath)
        
        cell.configure(item: elements[indexPath.row])
        //closure на последнюю строку
        cell.clickAction = { [weak self] in
            if let model = self?.elements[indexPath.row] {
//                self?.events.send(.buttonClicked(model))
            
               
            }
        }
        if(indexPath.row == elements.count-1){
            let footer = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            footer.color = .red
            locationCollectionView.addSubview(footer)
//            let footer = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//            footer.backgroundColor = .red
            //collectionView.tableFooterView = SwingerFooterView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            //footer.startAnimating()
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        events.send(.cellClicked(elements[indexPath.row]))
       }
    
}
