//
//  ProfileViewController.swift
//  VIBE_Client
//
//  Created by ndvor on 5/20/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    let url = Url()
    let defaults = `NSUserDefaults`.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = defaults.objectForKey("username") as! String
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "LogoutSegue" :
                _ = segue.destinationViewController as! UINavigationController
                break;
            case "ProfileSegue" :
                _ = segue.destinationViewController as! ProfileViewController
                break;
                
            default:
                break;
            }
        }
    }
    
    @IBAction func logoutBtnClicked(sender: UIButton) {
        Alamofire.request(.POST, url.userLogOutUrl)
            .responseJSON {_ in
        }
        
        defaults.setObject(nil, forKey: "username")
        
        print("[SEGUE] TO HOME (LOGOUT)");
        self.performSegueWithIdentifier("LogoutSegue", sender: sender)
    
    }
}
