//
//  UIImage.swift
//  Education
//
//  Created by Илья Кузнецов on 08.11.2022.
//

import UIKit

extension UIImage {
    func setColor(_ color: UIColor) -> UIImage {
        return self.withTintColor(color, renderingMode: .alwaysTemplate)
    }
}
