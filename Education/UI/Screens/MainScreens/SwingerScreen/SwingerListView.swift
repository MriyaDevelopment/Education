import UIKit
import Combine

final class SwingerListView: UIView {

    let events = PassthroughSubject<MainScreenViewEvents, Never>()

    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var elements: [Result] = []

    
 
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = MainFont.bold(size: 20)
        label.text = "Восемь планет солнечной системы"
        label.textAlignment = .center
        return label
    }()
    
  
   
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(SwingerTableViewCell.self)
        tableView.showsVerticalScrollIndicator = false
        
  
        tableView.alwaysBounceVertical = true

        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BaseColor.hex_ADAEB2.uiColor()
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {

        addSubview(contentView)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(tableView)

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
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
        
            make.bottom.equalToSuperview()
            
        }

    }
    
   

    func configure(elements: [Result]) {
        self.elements = elements
        print("Запуск \(elements.count)")
        tableView.reloadData()
    }
    
}

extension SwingerListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SwingerTableViewCell.self, for: indexPath)
        cell.configure(data: elements[indexPath.row])
//        cell.clickAction = { [weak self] in
//            if let model = self?.elements[indexPath.row] {
//                self?.events.send(.buttonClicked(model))
//            }
//        }
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        events.send(.cellClicked(elements[indexPath.row]))
//       }
}

