//
//  TagBarFlowLayout.swift
//  TagBar
//
//  Created by Ali Moazenzadeh on 4/11/19.
//  Copyright © 2019 Ali Moazenzadeh. All rights reserved.
//

import UIKit

class TagBarFlowLayout: UICollectionViewFlowLayout {

    var appearance = TagBarAppearance()
    var previousSize: CGSize = .zero

    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 11.0, *) {
            self.sectionInsetReference = .fromSafeArea
        }
    }

    override func prepare() {
        super.prepare()

        previousSize = collectionView!.bounds.size
        itemSize = CGSize(width: 85, height: appearance.textFont.pointSize + appearance.paddingY * 2)

        minimumLineSpacing = appearance.paddingX
        minimumInteritemSpacing = appearance.paddingX
        sectionInset = UIEdgeInsets(top: 0, left: appearance.marginX, bottom: 0, right: appearance.marginX)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let answer = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        let count = answer.count
        if count == 0 { return nil }

        for i in 1..<count {
            let currentLayoutAttributes = answer[i]
            let prevLayoutAttributes = answer[i-1]
            let origin = prevLayoutAttributes.frame.maxX
            if (origin + appearance.cellSpacing + currentLayoutAttributes.frame.size.width) < self.collectionViewContentSize.width && currentLayoutAttributes.frame.origin.x > prevLayoutAttributes.frame.origin.x {
                var frame = currentLayoutAttributes.frame
                frame.origin.x = origin + appearance.cellSpacing
                currentLayoutAttributes.frame = frame
            }
        }
        return answer
    }
}


