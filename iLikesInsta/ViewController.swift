//
//  ViewController.swift
//  iLikesInsta
//
//  Created by Samrez Ikram on 02/08/2016.
//  Copyright © 2016 crescentcatcher. All rights reserved.
//

import UIKit
import LFLoginController

class ViewController: UIViewController {

    let controller = LFLoginController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        controller.delegate = self
        
        // Customizations
        controller.logo = UIImage(named: "AwesomeLabsLogoWhite")
        controller.videoURL = NSBundle.mainBundle().URLForResource("PolarBear", withExtension: "mov")!
        controller.loginButtonColor = UIColor.purpleColor()
        controller.setupOnePassword("YourAppName", appUrl: "YourAppURL")
        self.navigationController?.showViewController(controller, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
extension ViewController: LFLoginControllerDelegate {
    
    func loginDidFinish(email: String, password: String, type: LFLoginController.SendType) {
        
        // Implement your server call here
        
        print(email)
        print(password)
        print(type)
        
        // Example
        if type == .Login && password != "1234" {
            
            controller.wrongInfoShake()
        }
        else if type == .Signup {
            
           UIAlertView(title: "Success", message: "You are signed up :)", delegate: self, cancelButtonTitle: "OKay").show()
        }
        else {
            let mainContrller = MainViewController()
//            self.navigationController?.setViewControllers([mainContrller], animated: true)
            
            
            let maincontroller = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
            self.showViewController(maincontroller, sender: self)
            }
    }
    
    func forgotPasswordTapped() {
        
        print("forgot password")
    }
}


