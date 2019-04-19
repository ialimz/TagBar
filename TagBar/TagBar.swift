//
//  TagBar.swift
//  TagBar
//
//  Created by Ali`s Macbook Pro on 4/19/19.
//  Copyright © 2019 alimz. All rights reserved.
//

import Foundation
import UIKit

public protocol TagBarDelegate: class {
    func tagBar(_ tagBar: TagBar, didSelectCell cell: TagBarCell, for item: TagBarItem, atIndexPath indexPath: IndexPath)
}

public protocol TagBarDataSource: class {
    func numberOfItems(in tagBar: TagBar) -> Int
}

public class TagBar: UIView {

    var items = [TagBarItem]()
    public weak var delegate: TagBarDelegate?
    public weak var dataSource: TagBarDataSource?

    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    var appearance = TagBarAppearance()

    public init(appearance: TagBarAppearance = TagBarAppearance(), frame: CGRect) {
        self.appearance = appearance
        super.init(frame: frame)
        setupView()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        Bundle.resourceBundle.loadNibNamed("TagBar", owner: nil, options: nil)
        contentView.fixInView(self)
    }

    var multiLine: Bool = false {
        didSet {
            setupLayout()
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TagBarCell", bundle: nil), forCellWithReuseIdentifier: "TagBarCell")
    }

    public func reloadData() {
        collectionView.reloadData()
    }

    fileprivate func setupLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        let layout = TagBarFlowLayout()
        layout.appearance = appearance
        layout.scrollDirection = multiLine ? .vertical : .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = !multiLine
    }

}

extension TagBar: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfItems(in: self) ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagBarCell", for: indexPath) as! TagBarCell
        cell.fill(with: items[indexPath.item])
        return cell
    }
}

extension TagBar: UICollectionViewDelegate {
    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagBarCell else { return }
        let item = items[indexPath.item]
        delegate?.tagBar(self, didSelectCell: cell, for: item, atIndexPath: indexPath)
    }
}
