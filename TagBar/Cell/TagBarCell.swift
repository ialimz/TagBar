//
//  TagBarCell.swift
//  TagBar
//
//  Created by Ali Moazenzadeh on 4/11/19.
//  Copyright © 2019 Ali Moazenzadeh. All rights reserved.
//

import UIKit

public class TagBarCell: UICollectionViewCell {

    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var titleLabel: UILabel!

    var id: Int?

    var didSelect: Bool = false {
        didSet {
            titleLabel.textColor = didSelect ? .white : .orange
            contentView.backgroundColor = didSelect ? .orange : .white
        }
    }

    func fill(with model: TagBarItem) {
        titleLabel.text = model.text ?? ""
        didSelect = model.isSelected
    }

}
