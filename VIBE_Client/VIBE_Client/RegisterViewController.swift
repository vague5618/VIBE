//
//  RegisterViewController.swift
//  wave
//
//  Created by ndvor on 3/21/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var repasswoTextfield: UITextField!
    @IBOutlet weak var realnameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    let url = Url()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Register2Login" :
                _ = segue.destinationViewController as! LoginViewController
                break;
                
            default:
                break;
            }
        }
    }
    
    @IBAction func btnClicked(sender: AnyObject) {
        if( usernameTextfield.text == "" ||
            passwordTextfield.text == "" || repasswoTextfield.text == "" ||
            realnameTextfield.text == "" || emailTextfield.text == ""){
            let alert = UIAlertView()
            alert.title = "Input"
            alert.message = "ALL Fields are required"
            alert.addButtonWithTitle("Confirm")
            alert.show()
        } else {
            if (passwordTextfield.text != repasswoTextfield.text) {
                let alert = UIAlertView()
                alert.title = "Password"
                alert.message = "Password NOT Matched"
                alert.addButtonWithTitle("Confirm")
                alert.show()
                
            } else {
                let param = [
                    "username" : usernameTextfield.text!,
                    "password" : passwordTextfield.text!,
                    "name" : realnameTextfield.text!,
                    "email" : emailTextfield.text!
                ]
                
                //Error 1 : Invalid input
                //Error 2 : User already exists
                Alamofire.request(.POST, url.userSignupUrl ,parameters: param)
                    .responseJSON { response in
                        print("Response from NODE JS Server : \(response.result.value)")
                        
                        if(response.result.value != nil) {
                            let alert = UIAlertView()
                            self.performSegueWithIdentifier("Register2Login", sender: nil)
                            alert.title = "Welcome"
                            alert.message = "Resiter Completed! Please Login!"
                            alert.addButtonWithTitle("Confirm")
                            alert.show()
                        }
                }
            }
            
        }
    }
    
}
