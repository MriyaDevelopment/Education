//
//  BaseFont.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

enum MainFont {
    static func semiBold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "LibreBaskerville-Bold", size: size) else { return UIFont() }
        return font
    }
    
    static func bold(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "LibreBaskerville-Bold", size: size) else { return UIFont() }
        return font
    }
        
    static func regular(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "LibreBaskerville-Regular", size: size) else { return UIFont() }
        return font
    }
    
    static func medium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "LibreBaskerville-Regular", size: size) else { return UIFont() }
        return font
    }
}

extension UIFont {
  func withWeight(_ weight: UIFont.Weight) -> UIFont {
    let newDescriptor = fontDescriptor.addingAttributes([.traits: [
      UIFontDescriptor.TraitKey.weight: weight]
    ])
    return UIFont(descriptor: newDescriptor, size: pointSize)
  }
}
