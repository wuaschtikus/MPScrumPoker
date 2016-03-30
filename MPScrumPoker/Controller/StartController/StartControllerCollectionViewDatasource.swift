//
//  StartControllerCollectionViewDatasource.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 30.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class StartControllerCollectionViewDatasource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var startController:ViewController!
    
    // MARK:  Lifecycle
    
    init(startController:ViewController) {
        self.startController = startController
    }

    // MARK: - UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    @objc func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCell", forIndexPath: indexPath)
        
        return cell
    }
}