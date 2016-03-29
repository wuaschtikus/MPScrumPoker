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
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func startStopAdvertizing(sender: AnyObject) {
    }
    
    // MARK: - Properties
    
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    
    var startTableViewDatasource:StartControllerTableViewDatasoure! {
        willSet {
            self.tableView.dataSource = newValue
            self.tableView.reloadData()
        }
    }
    var startTableViewDelegate:StartControllerTableViewDelegate! {
        willSet {
            self.tableView.delegate = newValue
        }
    }
    
    
    // MARK:  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // setup tableview
        
        self.prepareTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
    
    func prepareTableView() {
        self.startTableViewDelegate = StartControllerTableViewDelegate(startController: self)
        self.startTableViewDatasource = StartControllerTableViewDatasoure(startController: self)
    }
    
    
}

