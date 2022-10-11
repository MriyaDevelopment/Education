//
//  MainModel.swift
//  Education
//
//  Created by Nikita Ezhov on 30.09.2022.
//
import UIKit
import SwiftUI
import Foundation

//public struct MainModel {
//    var id: Int
//    var title: String
//    var subtitle: String
//}



enum MainViewEvent {
    case cellClicked(String)
    case firstCellClicked
    case switchToProfile
}



struct MainStruct {
    var id: Int
    var backgroundImage: UIImage
    var type: String
    var titleText: String
    var subtitleText: String
    static let placeholderItems: [MainStruct] = [
        .init(id: 1, backgroundImage: UIImage(named: "Mercury")!, type: "", titleText: "Солнечная система", subtitleText: "МЕРКУРИЙ"),
        .init(id: 2, backgroundImage: UIImage(named: "Venus")!, type: "", titleText: "Солнечная система", subtitleText: "ВЕНЕРА"),
        .init(id: 3, backgroundImage: UIImage(named: "Earth")!,type: "", titleText: "Солнечная система", subtitleText: "ЗЕМЛЯ"),
        .init(id: 4, backgroundImage: UIImage(named: "Mars")!, type: "", titleText: "Солнечная система", subtitleText: "МАРС"),
        .init(id: 5, backgroundImage: UIImage(named: "Jupiter")!, type: "", titleText: "Солнечная система", subtitleText: "ЮПИТЕР"),
        .init(id: 6, backgroundImage: UIImage(named: "Uran")!, type: "", titleText: "Солнечная система", subtitleText: "УРАН"),
        .init(id: 7, backgroundImage: UIImage(named: "Neptun")!, type: "", titleText: "Солнечная система", subtitleText: "НЕПТУН"),
        .init(id: 8, backgroundImage: UIImage(named: "Pluton")!,  type: "", titleText: "Солнечная система", subtitleText: "ПЛУТОН"),
    ]
    
    
}


//placeholderItems
