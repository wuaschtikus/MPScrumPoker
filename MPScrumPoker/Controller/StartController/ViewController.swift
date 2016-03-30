//
//  ViewController.swift
//  MPScrumPoker
//
//  Created by wuaschtikus on 29.03.16.
//  Copyright © 2016 midori. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import CleanroomLogger

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func startStopAdvertizing(sender: AnyObject) {
    }
    
    // MARK: - Properties
    
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var startCollectionViewDatasource:StartControllerCollectionViewDatasource! {
        willSet {
            self.collectionView.dataSource = newValue
            self.collectionView.reloadData()
        }
    }
    
    var startCollectionViewDelegate:StartCollectionViewDelegate! {
        willSet {
            self.collectionView.delegate = newValue
        }
    }
    
    // MARK:  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tableview
        
        self.prepareCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    func prepareCollectionView() {
        self.startCollectionViewDelegate = StartCollectionViewDelegate(startController: self)
        self.startCollectionViewDatasource = StartControllerCollectionViewDatasource(startController: self)
    }
}

