//
//  UserPhotosViewController.swift
//  iLikesInsta
//
//  Created by Samrez Ikram on 03/08/2016.
//  Copyright © 2016 crescentcatcher. All rights reserved.
//


import UIKit
import KRLCollectionViewGridLayout
import BetterSegmentedControl

let SourceSansProSemibold = "SourceSansPro-Semibold"
private let reuseIdentifier = "Cell"
private let headerFooterIdentifier = "headerFooter"

class UserPhotosViewController: UICollectionViewController {
    
    var layout: KRLCollectionViewGridLayout {
        return self.collectionView?.collectionViewLayout as! KRLCollectionViewGridLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mySegmentView:UISegmentedControl!
        
        self.setupSegmentController()
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(UserPhotosViewController.confirmLogout))
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton: UIBarButtonItem = UIBarButtonItem(title: "0", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightButton

        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
//        collectionView?.registerClass(HeaderFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerFooterIdentifier)
//        collectionView?.registerClass(HeaderFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: headerFooterIdentifier)
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

    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        cell.viewWithTag(101)?.removeFromSuperview()
        cell.viewWithTag(102)?.removeFromSuperview()
        // Configure the cell
        if indexPath.section % 2 == 1 {
            cell.contentView.backgroundColor = UIColor.blueColor()
        } else {
            let friendPicture: UIImageView = UIImageView(frame: CGRectMake(cell.bounds.origin.x + 22.5, cell.bounds.origin.y + 8, cell.bounds.width - 45, cell.bounds.height - 45) )
            friendPicture.contentMode = UIViewContentMode.ScaleToFill
            friendPicture.layer.cornerRadius = friendPicture.frame.size.height/2
            friendPicture.clipsToBounds = true
            friendPicture.image = UIImage(named: "tg\(indexPath.row + 1 ).jpg")
            
            friendPicture.tag = 101
            cell.addSubview(friendPicture)
            let friendName: UILabel = UILabel(frame: CGRectMake( cell.bounds.origin.x  , cell.bounds.origin.y + friendPicture.frame.height  , cell.bounds.width , cell.bounds.height - friendPicture.frame.height ) )
            
            
            friendName.textColor = UIColor(red: 102/255.0, green: 102/255, blue: 102/255, alpha: 1)
            friendName.font = UIFont(name: SourceSansProSemibold, size: 12.0)
            friendName.numberOfLines = 0;
            friendName.textAlignment = NSTextAlignment.Center
            friendName.tag = 102
            friendName.text = "1 <3"
            cell.addSubview(friendName)
            //cell.contentView.backgroundColor = UIColor.redColor()
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("selectedImage", sender: indexPath);
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
        navigationSegmentedControl.addTarget(self, action: #selector(UserPhotosViewController.navigationSegmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        do{
            try navigationSegmentedControl.setIndex(1)
        }catch{
            print("handle Error");
        }
        navigationItem.titleView = navigationSegmentedControl
    }
    func navigationSegmentedControlValueChanged(sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Earn Coins.")
            self.navigationController?.popViewControllerAnimated(true)
            view.backgroundColor = UIColor(red: 224 / 255, green: 68 / 255, blue: 98 / 255, alpha: 1)
        }
        else {
            print("Get Likes.")
            view.backgroundColor = .darkGrayColor()
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectedImage"{
            let getLikes = segue.destinationViewController as? GetLikesViewController
            getLikes?.selectedIndex = (sender as? NSIndexPath)?.row
            getLikes?.title = "Get Likes"
        }
    }


    
}

extension UserPhotosViewController: KRLCollectionViewDelegateGridLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let inset = CGFloat((section + 1) * 10)
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, interitemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat((section + 1) * 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, lineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return CGFloat((section + 1) * 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceLengthForHeaderInSection section: Int) -> CGFloat {
        return CGFloat((section + 1) * 20)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceLengthForFooterInSection section: Int) -> CGFloat {
        return CGFloat((section + 1) * 20)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, numberItemsPerLineForSectionAtIndex section: Int) -> Int {
        return self.layout.numberOfItemsPerLine + (section * 1)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, aspectRatioForItemsInSectionAtIndex section: Int) -> CGFloat {
        return CGFloat(1 + section)
    }
}
