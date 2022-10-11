//
//  UiCollectionView.swift
//  Education
//
//  Created by Роман Приладных on 04.10.2022.
//

import UIKit

extension UICollectionView {
    
    func didHighlightRowAt(at indexPath: IndexPath) {
        guard let cell = self.cellForItem(at: indexPath) as? AnimationCollectionViewCellProtocol else { return }
        cell.animationScale(for: cell, indexPath: indexPath, collectionView: self)
    }
    
    func didUnhighlightRowAt(at indexPath: IndexPath) {
        guard let cell = self.cellForItem(at: indexPath) as? AnimationCollectionViewCellProtocol else { return }
        cell.animationIdentity(for: cell, indexPath: indexPath, collectionView: self)
    }
}
