//
//  UIImageView+Ext.swift
//  Education
//
//  Created by Nikita Ezhov on 06.11.2022.
//

import UIKit

extension UIImageView {
    func loadArticleImage(by imageURL: String, completionHandler: VoidClosure? = nil) {
        guard !imageURL.isEmpty else {
            self.image = AppIcons.getIcon(.i_heart_input)
            return
        }
        
        let path = "http://ovz4.j04713753.pv29m.vps.myjino.ru/image/\(imageURL)"
        guard let url = URL(string: path) else {
            self.image = AppIcons.getIcon(.i_heart_input)
            return }
        let placeholderView = ImagePreloaderView()
        
        self.kf.setImage(with: url,
                         placeholder: placeholderView) { (result) in
            switch result {
            case .success(_):
                self.backgroundColor = .clear
            case .failure(let error):
                print(error)
                self.image = AppIcons.getIcon(.i_heart_input)
            }
            completionHandler?()
        }
    }
}
