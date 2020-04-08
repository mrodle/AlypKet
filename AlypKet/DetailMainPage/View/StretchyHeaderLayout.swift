//
//  StretchyHeaderLayout.swift
//  AlypKet
//
//  Created by Zhanibek Santay on 4/7/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        attributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader && attribute.indexPath.section == 0{
                guard let collectionview = collectionView else {return}
                let contentOffsetY = collectionview.contentOffset.y
                if contentOffsetY > 0 {
                    return
                }
                let width = collectionview.frame.width
                let height = attribute.frame.height
                attribute.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height - contentOffsetY)
            }
        })
        return attributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
