//
//  BundleExtension.swift
//  TagBar
//
//  Created by Ali`s Macbook Pro on 4/18/19.
//  Copyright © 2019 Ali Moazenzadeh. All rights reserved.
//

import Foundation

extension Bundle {
    static var tagBarBundle: Bundle {
        let bundle = Bundle(for: TagBar.classForCoder())
        let bundleURL = bundle.url(forResource: "TagBar", withExtension: "bundle")
        return bundleURL.flatMap(Bundle.init(url:)) ?? bundle
    }

    static var tagBarCellBundle: Bundle {
        let bundle = Bundle(for: TagBarCell.self)
        let bundleURL = bundle.url(forResource: "TagBar", withExtension: "bundle")
        return bundleURL.flatMap(Bundle.init(url:)) ?? bundle
    }
}
