//
//  SearchViewController.swift
//  VIBE_Client
//
//  Created by ndvor on 5/20/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import UIKit
import Toast_Swift

class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var captionTextView: UITextField!
    @IBOutlet weak var previewImageView: UIImageView!
    
    override func viewDidLoad() {
        title = "Upload"
        super.viewDidLoad()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.previewImageView.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addImageBtnClicked(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        imagePicker.allowsEditing = false
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func click_btnRecognize(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func nextBtnClicked(sender: AnyObject) {
        print("[SEGUE] TO NEXT (FOR UPLOAD)");
        self.performSegueWithIdentifier("UploadNextSegue", sender: sender)
    }
    
    
    
}
