//
//  StringExtension.swift
//  TagBar
//
//  Created by Ali`s Macbook Pro on 4/26/19.
//  Copyright © 2019 alimz. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    func getSize(with font: UIFont) -> CGSize {
        return size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
