//
//  MainViewController.swift
//  iLikesInsta
//
//  Created by Samrez Ikram on 03/08/2016.
//  Copyright © 2016 crescentcatcher. All rights reserved.
//

import UIKit
import BetterSegmentedControl

//import SPTinderViewCell

extension MainViewController: SPTinderViewDataSource, SPTinderViewDelegate {
    func numberOfItemsInTinderView(view: SPTinderView) -> Int {
        return 20
    }
    
    func tinderView(view: SPTinderView, cellAt index: Int) -> SPTinderViewCell? {
        if let cell = tinderView.dequeueReusableCellWithIdentifier(cellIdentifier) as? MyCustomTinderCell {
            cell.imageView.image = TinderModel.randomImage()
            cell.titleLabel.text = "Model No: \(index+1)"
            return cell
        }
        return nil
    }
    
    func tinderView(view: SPTinderView, didMoveCellAt index: Int, towards direction: SPTinderViewCellMovement) {
        print("\(direction)")
    }
}


class MainViewController: UIViewController {

    var mySegmentView:UISegmentedControl!
    @IBOutlet var tinderView: SPTinderView!
    let cellIdentifier = "MyCustomTinderCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSegmentController()
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MainViewController.confirmLogout))
        navigationItem.leftBarButtonItem = leftButton
    
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: "0", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightButton
        
        tinderView.frame = self.view.frame
        tinderView.registerNib(UINib(nibName: "MyCustomTinderCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tinderView.delegate = self
        tinderView.dataSource = self

        tinderView.backgroundColor = UIColor.whiteColor()
        
       //        navigationItem. = [leftbutton, leftbutton]
    }
    
    func confirmLogout(){
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Logout", message: "samrezikram@yahoo.com", preferredStyle: .Alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("Yes Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    func navigationSegmentedControlValueChanged(sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Earn Coins.")
            view.backgroundColor = UIColor(red: 224 / 255, green: 68 / 255, blue: 98 / 255, alpha: 1)
        }
        else {
            print("Get Likes.")
            view.backgroundColor = .darkGrayColor()
            self.performSegueWithIdentifier("temp", sender: self)
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupSegmentController(){
        let navigationSegmentedControl = BetterSegmentedControl(
            frame: CGRect(x: 35.0, y: 40.0, width: 200.0, height: 30.0),
            titles: ["Earn Coins", "Get Likes"],
            index: 0,
            backgroundColor: .darkGrayColor(),
            titleColor: .lightGrayColor(),
            indicatorViewBackgroundColor: UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00),
            selectedTitleColor: .whiteColor())
        navigationSegmentedControl.cornerRadius = 3.0
        navigationSegmentedControl.titleFont = UIFont(name: "Avenir", size: 13.0)!
        navigationSegmentedControl.selectedTitleFont = UIFont(name: "Avenir", size: 13.0)!
        navigationSegmentedControl.bouncesOnChange = false
        navigationSegmentedControl.addTarget(self, action: #selector(MainViewController.navigationSegmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        navigationItem.titleView = navigationSegmentedControl
    }
 
}
