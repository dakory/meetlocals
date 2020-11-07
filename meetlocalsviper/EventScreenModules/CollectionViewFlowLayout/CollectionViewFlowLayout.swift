//
//  CollectionViewFlowLayout.swift
//  meetlocalsviper
//
//  Created by Софья Тимохина on 25.10.2020.
//

import UIKit

final class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        scrollDirection = .vertical
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        itemSize = CGSize(width: UIScreen.main.bounds.width, height: ((collectionView?.frame.height)! - 8 * minimumLineSpacing) / 8)
    }
}

