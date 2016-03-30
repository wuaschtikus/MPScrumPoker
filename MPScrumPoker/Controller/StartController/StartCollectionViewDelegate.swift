//
//  StartCollectionViewDelegate.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 30.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class StartCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    struct LayoutConstants {
        static let spacing = 10
        static let sections = 3
        static let rows = 3
    }
    
    var startController:ViewController!
    var itemSize:CGSize!
    
    // MARK: - Lifecycle
    
    init(startController:ViewController) {
        super.init()
        self.startController = startController
        self.itemSize = CGSizeMake(self.calculateItemWidth(), self.calculateItemHeight())
    }
    
    // MARK: - Private
    
    func calculateItemHeight() -> CGFloat {
        if let windowBounds = UIApplication.sharedApplication().keyWindow?.rootViewController?.view.frame.size {
            var height = windowBounds.height - CGFloat(LayoutConstants.rows * (LayoutConstants.spacing + 2)) - 64
            height = height / 3
            
            return height
        }
        
        return 0
    }
    
    func calculateItemWidth() -> CGFloat {
        if let windowBounds = UIApplication.sharedApplication().keyWindow?.rootViewController?.view.frame.size {
            var width = windowBounds.width - CGFloat(LayoutConstants.spacing * (LayoutConstants.sections + 1))
            width = width / 3
            
            return width
        }
        
        return 0
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.itemSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
}