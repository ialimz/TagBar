//
//  BundleExtension.swift
//  TagBar
//
//  Created by Ali`s Macbook Pro on 4/18/19.
//  Copyright © 2019 Ali Moazenzadeh. All rights reserved.
//

import Foundation

extension Bundle {
    static var resourceBundle: Bundle {
        let sourceBundle = Bundle(for: TagBar.self)
        let bundleURL = sourceBundle.url(forResource: "TagBar", withExtension: "bundle")
        return bundleURL.flatMap(Bundle.init(url:)) ?? sourceBundle
    }
}
