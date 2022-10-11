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
//        label.textColor = BaseColor.hex_232324.uiColor()
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
        

//        subscribesButton.snp.makeConstraints { (make) in
//            make.centerY.equalTo(titleLabel)
//            make.right.equalToSuperview().inset(16)
//        }

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
    
    
    
  
    @objc private func clickedAction() {
        let model = MainStruct(id: 1, backgroundImage: UIImage(named: "")!, type: "", titleText: "", subtitleText: "")
            events.send(.buttonClicked(model))
        }
   

}

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionReusableCell(withType: MainCollectionViewCell.self, for: indexPath)
        cell.configure(item: elements[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           events.send(.buttonClicked(elements[indexPath.row]))
       }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //    private let label: UILabel = {
    //        let label = UILabel()
    //        label.text = "Education"
    //        label.font = MainFont.bold(size: 24)
    //        return label
    //    }()
    //
    //    private let button: UIButton = {
    //        let button = UIButton()
    //        button.setTitle("Click me", for: .normal)
    //        button.titleLabel?.font = MainFont.bold(size: 20)
    //        button.setTitleColor(BaseColor.hex_E73626.uiColor(), for: .normal)
    //        return button
    //    }()
    //
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //        backgroundColor = BaseColor.hex_FFFFFF.uiColor()
    //
    //        addElements()
    //        addTargets()
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //
    //    private func addElements() {
    //        addSubview(label)
    //        addSubview(button)
    //        makeConstraints()
    //    }
    //
    //    private func makeConstraints() {
    //
    //        label.snp.makeConstraints { make in
    //            make.centerY.centerX.equalToSuperview()
    //        }
    //
    //        button.snp.makeConstraints { make in
    //            make.top.equalTo(label.snp.bottom).offset(25)
    //            make.centerX.equalToSuperview()
    //        }
    //    }
    //
     
    
    
    
    
    
    
    
}

