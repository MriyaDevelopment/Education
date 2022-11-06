//
//  MainModel.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//
import UIKit
import SwiftUI
import Foundation

struct MainStruct {
    var id: Int
    var backgroundImage: UIImage
    var type: String
    var titleText: String
    var subtitleText: String
    var descriptionText: String
    static let placeholderItems: [MainStruct] = [
        .init(id: 1, backgroundImage: UIImage(named: "Mercury")!, type: "", titleText: "Солнечная система", subtitleText: "МЕРКУРИЙ", descriptionText: "ПЕРВАЯ ПЛАНЕТА"),
        .init(id: 2, backgroundImage: UIImage(named: "Venus")!, type: "", titleText: "Солнечная система", subtitleText: "ВЕНЕРА" , descriptionText: "ВТОРАЯ ПЛАНЕТА"),
        .init(id: 3, backgroundImage: UIImage(named: "Earth")!,type: "", titleText: "Солнечная система", subtitleText: "ЗЕМЛЯ", descriptionText: "ТРЕТЬЯ ПЛАНЕТА"),
        .init(id: 4, backgroundImage: UIImage(named: "Mars")!, type: "", titleText: "Солнечная система", subtitleText: "МАРС", descriptionText: "ЧЕТВЁРТАЯ ПЛАНЕТА"),
        .init(id: 5, backgroundImage: UIImage(named: "Jupiter")!, type: "", titleText: "Солнечная система", subtitleText: "ЮПИТЕР", descriptionText: "ПЯТАЯ ПЛАНЕТА"),
        .init(id: 6, backgroundImage: UIImage(named: "Uran")!, type: "", titleText: "Солнечная система", subtitleText: "УРАН", descriptionText: "СЕДЬМАЯ ПЛАНЕТА"),
        .init(id: 7, backgroundImage: UIImage(named: "Neptun")!, type: "", titleText: "Солнечная система", subtitleText: "НЕПТУН", descriptionText: "ВОСЬМАЯ ПЛАНЕТА"),
        .init(id: 8, backgroundImage: UIImage(named: "Pluton")!,  type: "", titleText: "Солнечная система", subtitleText: "ПЛУТОН", descriptionText: "ДЕВЯТАЯ ПЛАНЕТА"  ),
    ]
    
}



