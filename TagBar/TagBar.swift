//
//  TagBar.swift
//  TagBar 1
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
    func item(forIndex index: Int) -> TagBarItem
}

public class TagBar: UIView {

    public weak var delegate: TagBarDelegate?
    public weak var dataSource: TagBarDataSource?

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    public var appearance = TagBarAppearance() {
        didSet {
            setupLayout()
        }
    }

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
        Bundle.tagBarBundle.loadNibNamed("TagBar", owner: self, options: nil)
        contentView.fixInView(self)
    }

    public var multiLine: Bool = false {
        didSet {
            setupLayout()
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    func setupCollectionView() {
        setupLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TagBarCell", bundle: Bundle.tagBarCellBundle), forCellWithReuseIdentifier: "TagBarCell")
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }

}

extension TagBar: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfItems(in: self) ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagBarCell", for: indexPath) as! TagBarCell
        if let item = dataSource?.item(forIndex: indexPath.item) {
            cell.fill(with: item)
        }
        return cell
    }
}

extension TagBar: UICollectionViewDelegate {
    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagBarCell else { return }
        if let item = dataSource?.item(forIndex: indexPath.item) {
            delegate?.tagBar(self, didSelectCell: cell, for: item, atIndexPath: indexPath)
        }
    }
}

extension TagBar: UICollectionViewDelegateFlowLayout {
    private func collectionView(_: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? TagBarFlowLayout else { return .zero }
        guard let item = dataSource?.item(forIndex: indexPath.item) else { return layout.itemSize }
        var width = item.text?.getSize(with: appearance.textFont).width ?? 0.0
        width += (appearance.paddingX * 2)
        return CGSize(width: width, height: layout.itemSize.height)
    }
}
