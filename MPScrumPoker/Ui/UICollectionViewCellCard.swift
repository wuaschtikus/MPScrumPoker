//
//  UICollectionViewCellCard.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 30.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit

class UICollectionViewCellCard: UICollectionViewCell {
    
    @IBOutlet weak var roundCornersView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layer.cornerRadius = 2.0;
        self.contentView.layer.borderWidth = 1.0;
        self.contentView.layer.borderColor = UIColor.clearColor().CGColor;
        self.contentView.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.grayColor().CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2.0;
        self.layer.shadowOpacity = 1.0;
        self.layer.masksToBounds = false;
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).CGPath;
    }
}