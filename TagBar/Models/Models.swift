//
//  Models.swift
//  TagBar
//
//  Created by Ali Moazenzadeh on 4/11/19.
//  Copyright © 2019 Ali Moazenzadeh. All rights reserved.
//

import Foundation

public struct TagBarItem {
    let text: String?
    let isSelected: Bool
    let value: Any

    public init(text: String?, isSelected: Bool = false, value: Any) {
        self.text = text
        self.isSelected = isSelected
        self.value = value
    }
}

public struct TagBarAppearance {
    let paddingX: CGFloat
    let paddingY: CGFloat
    let marginX: CGFloat
    let cellSpacing: CGFloat
    let textFont: UIFont

    public init(paddingX: CGFloat = 8.0,
         paddingY: CGFloat = 8.0,
         marginX: CGFloat = 19.0,
         cellSpacing: CGFloat = 5.0,
         textFont: UIFont = .systemFont(ofSize: 14)) {
        self.paddingX = paddingX
        self.paddingY = paddingY
        self.marginX = marginX
        self.cellSpacing = cellSpacing
        self.textFont = textFont
    }
}
