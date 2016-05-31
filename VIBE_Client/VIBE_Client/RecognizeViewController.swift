//
//  RecognizeViewController.swift
//  VIBE_Client
//
//  Created by JAEYONG BAE on 2016. 5. 23..
//  Copyright © 2016년 ndvor. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class RecognizeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let url = Url()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btn_recognize: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    //이미지 인식버튼 클릭시 카메라를 켜고 패턴인식 진행
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Recognize2Play" :
                _ = segue.destinationViewController as! PlayerViewController
                break;
            default:
                break;
            }
        }
    }
    
    
    //이미지를 가져온다면 openCV Wrapper클래스를 통해 이진화, 외곽선 변환작업을 시작한다.
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        ConvertImage(image)
    }
    
    func ConvertImage(image: UIImage){
        
        let crop = OpenCVWrapper.centerCropImage(image)
        let edgeimage = OpenCVWrapper.DetectEdgeWithImage(crop);
        let byte = OpenCVWrapper.getByte(crop);
        
        
        let param = [
            "array" : byte
        ]
        //to checkArray
        Alamofire.request(.POST, url.checkArrayUrl, parameters: param)
            .responseJSON {
                response in
                print("Response from NODE JS Server : \n\(response.result.value)")
                print("[SEGUE] TO Play");
                
              
                let ret = response.result.value as! NSNumber
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
                let defaults = `NSUserDefaults`.standardUserDefaults()
                
                defaults.setObject("2" , forKey: "fromWhat")
                
                NSLog(String(ret))
                
                defaults.setObject(String(ret), forKey: "imageIndex")
                defaults.synchronize()
                
            self.performSegueWithIdentifier("Recognize2Play", sender: nil)
        }
        
        //이미지에 대한 정보를 파일에 출력
        imageView.image = edgeimage
    }
}