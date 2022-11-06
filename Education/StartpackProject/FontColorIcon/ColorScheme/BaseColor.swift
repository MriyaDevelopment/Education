//
//  BaseColor.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//

import UIKit

enum BaseColor {

    static let hex_E73626 = SchemeColor(dark: Dark.hex_E73626, light: Light.hex_E73626)
    static let hex_ADAEB2 = SchemeColor(dark: Dark.hex_ADAEB2, light: Light.hex_ADAEB2)
    static let hex_FFFFFF = SchemeColor(dark: Dark.hex_FFFFFF, light: Light.hex_FFFFFF)
    static let hex_F1F1F1 = SchemeColor(dark: Dark.hex_F1F1F1, light: Light.hex_F1F1F1)
    static let hex_A5A7AD = SchemeColor(dark: Dark.hex_A5A7AD, light: Light.hex_A5A7AD)
    static let hex_1B1919 = SchemeColor(dark: Dark.hex_1B1919, light: Light.hex_1B1919)
    static let hex_D4D4D4 = SchemeColor(dark: Dark.hex_1B1919, light: Light.hex_1B1919)
    
        
    static func setGradientLayer(_ view: UIView) {
        let layer = CAGradientLayer()

        layer.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
          UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        ]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0.5, y: 0.25)
        layer.endPoint = CGPoint(x: 0.5, y: 0.75)
        layer.frame = view.frame
        view.backgroundColor = .white
        view.layer.insertSublayer(layer, at: 0)
    }
    
    private enum Light {
        static let hex_E73626 = UIColor(red: 0.91, green: 0.21, blue: 0.15, alpha: 1)
        static let hex_ADAEB2 = UIColor(red: 0.68, green: 0.68, blue: 0.7, alpha: 1)
        static let hex_FFFFFF = UIColor.white
        static let hex_F1F1F1 = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        static let hex_A5A7AD = UIColor(red: 0.647, green: 0.655, blue: 0.678, alpha: 1)
        static let hex_1B1919 = UIColor(red: 0.106, green: 0.098, blue: 0.098, alpha: 1)
        static let hex_D4D4D4 = UIColor(red: 0.106, green: 0.098, blue: 0.098, alpha: 1)
        static let hex_469ED1 = UIColor(red: 0.106, green: 0.098, blue: 0.098, alpha: 1)
    }
    
    private enum Dark {
        static let hex_E73626 = UIColor(red: 0.91, green: 0.21, blue: 0.15, alpha: 1)
        static let hex_ADAEB2 = UIColor(red: 0.68, green: 0.68, blue: 0.7, alpha: 1)
        static let hex_FFFFFF = UIColor.white
        static let hex_F1F1F1 = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        static let hex_A5A7AD = UIColor(red: 0.647, green: 0.655, blue: 0.678, alpha: 1)
        static let hex_1B1919 = UIColor(red: 0.106, green: 0.098, blue: 0.098, alpha: 1)
        static let hex_D4D4D4 = UIColor(red: 0.106, green: 0.098, blue: 0.098, alpha: 1)
        static let hex_469ED1 = UIColor(red: 0.106, green: 0.098, blue: 0.098, alpha: 1)
    }
}
