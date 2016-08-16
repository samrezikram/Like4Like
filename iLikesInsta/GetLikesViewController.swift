//
//  GetLikesViewController.swift
//  iLikesInsta
//
//  Created by Samrez Ikram on 03/08/2016.
//  Copyright © 2016 crescentcatcher. All rights reserved.
//

import UIKit

class GetLikesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var selectedImage: UIImageView!
    
    
    let likesType = ["10 Likes", "15 Likes", "20 Likes", "25 Likes", "30 Likes"]
    @IBOutlet var listTabeView: UITableView!
    
    let textCellIdentifier = "TextCell"
    var selectedIndex:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Get Likes"
        
        listTabeView.dataSource = self
        listTabeView.delegate  = self
        if selectedImage != nil {
            selectedImage.image = UIImage(named: "tg\(selectedIndex! + 1 ).jpg")

        }
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       

    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.listTabeView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        UIAlertView(title: "Row Tapped", message: "You selected choice  is \(likesType[row])", delegate: self, cancelButtonTitle: "OKay").show()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likesType.count
    }
    

    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = likesType[row]
      
        return cell
    }
    

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if( UIScreen.mainScreen().bounds.height == 480 ) //4s
        {
            return 50
        }
        else if( UIScreen.mainScreen().bounds.height == 568) //5s
        {
            return 50
        }
        else if ( UIScreen.mainScreen().bounds.height == 667 ) //6S
        {
            return 50
        }
        else if( UIScreen.mainScreen().bounds.height == 736 )    //6S+
        {
            return 50.5
        }
        else {
            
            return 50
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
