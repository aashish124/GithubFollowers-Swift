//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Aashish Ahlawat on 13/01/24.
//

import UIKit

class UIHelper {
    
    static func getThreeColumnCollectionViewLayout(view : UIView) -> UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let sidePadding: CGFloat = 12
        let internalSpacing : CGFloat = 10
        let totalWidth = view.bounds.width
        let availableWidth = totalWidth - (sidePadding * 2) - (internalSpacing * 2)
        let itemWidth = availableWidth / 3
        collectionViewLayout.sectionInset = UIEdgeInsets(top: sidePadding, left: sidePadding, bottom: sidePadding, right: sidePadding)
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

        return collectionViewLayout
    }
}
