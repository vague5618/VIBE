//
//  LoginViewController.swift
//  wave
//
//  Created by ndvor on 3/21/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    let url = Url()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            
            case "Login2Register" :
                _ = segue.destinationViewController as! RegisterViewController
                break;
                
            default:
                break;
            }
        }
    }
    
    
    @IBAction func btnClicked(sender: AnyObject) {
        
        //self.performSegueWithIdentifier("HomeSegue", sender: nil)
        
        let alert = UIAlertView()
        if(usernameTextfield == "" || passwordTextfield=="") {
            
            alert.title = "Input"
            alert.message = "ALL fields are required"
            alert.addButtonWithTitle("Confirm")
            alert.show()
            
        } else {
            
            let param = [
                "username" : usernameTextfield.text!,
                "password" : passwordTextfield.text!
            ]
            
            Alamofire.request(.POST, url.userLoginUrl,parameters: param)
                .responseJSON {
                    
                    response in
                    print("Response from NODE JS Server : \n\(response.result.value)")
                    
                    if(response.result.value != nil) {
                        let jsonData = JSON(response.result.value!)
                        
                        let res = jsonData["SERVER_MESSAGE"].stringValue
                        if(res == "Logged in!") {
                            
                            self.performSegueWithIdentifier("HomeSegue", sender: nil)
                            
                            alert.title = "Welcome"
                            alert.message = "Login Successfully"
                            alert.addButtonWithTitle("Confirm")
                            alert.show()
                    
                            let defaults = `NSUserDefaults`.standardUserDefaults()
                            defaults.setObject(self.usernameTextfield.text , forKey: "username")
                            defaults.synchronize()
                            print("username=\(defaults.objectForKey("username") as! String)")
                        } else {
                            alert.title = "Input"
                            alert.message = "Please Check Username & Password"
                            alert.addButtonWithTitle("Confirm")
                            alert.show()
                        }
                        
                    }
                    
            }
        }
        
    }
    
    @IBAction func toRegBtnClicked(sender: AnyObject) {
        
        print("[SEGUE] TO REGISTER");
        self.performSegueWithIdentifier("Login2Register", sender: sender)
    }
    
}


