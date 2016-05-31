//
//  PlaylistViewController.swift
//  wave
//
//  Created by ndvor on 3/17/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation
import Toast_Swift

class PatternViewController: UIViewController {
    
    // MARK : - Properties
    @IBOutlet weak var coverImage0: UIImageView!
    @IBOutlet weak var coverImage1: UIImageView!
    @IBOutlet weak var coverImage2: UIImageView!
    @IBOutlet weak var coverImage3: UIImageView!
    @IBOutlet weak var coverImage4: UIImageView!
    @IBOutlet weak var coverImage5: UIImageView!
    @IBOutlet weak var coverImage6: UIImageView!
    @IBOutlet weak var coverImage7: UIImageView!
    @IBOutlet weak var coverImage8: UIImageView!

    
    var coverImages: [UIImageView]!
    
    @IBOutlet weak var nowplayingBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var progSlider: UISlider!
    @IBOutlet weak var uploadBtn: UIBarButtonItem!
    @IBOutlet weak var profileBtn: UIBarButtonItem!
    
    let defaults = `NSUserDefaults`.standardUserDefaults()
    var player:AVAudioPlayer?
    
    // MARK : - View Contriller life Cycle
    
    // gets called whenever view is loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        coverImages = [coverImage0,coverImage1,coverImage2,coverImage3,coverImage4,
                       coverImage5,coverImage6,coverImage7,coverImage8]
        updateUI()
        initPlay()
    }
    
    
    func initPlay() {
        
        let myFilePathString = NSBundle.mainBundle().pathForResource("spo", ofType: "mp3")
        if let myFilePathString = myFilePathString {
            let myFilePathURL = NSURL(fileURLWithPath: myFilePathString)
            do {
                try player = AVAudioPlayer(contentsOfURL: myFilePathURL)
                
            } catch {
                print("Error")
            }
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
            print("Receiving remote control events\n")
        } catch {
            print("Audio Session error.\n")
        }
    }
    
    func updateUI() {
        for i in 0..<coverImages.count {
            let coverImage = coverImages[i]
            //Get the album
            let album = Album(index: i)
            coverImage.image = UIImage(named: album.coverImageName!)
        }
    }

    func stopPlayer() {
        player?.stop()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "PlaySegue" :
                // sender is UITapGestureRecognizer
                // do something
                
                
                let playerViewController = segue.destinationViewController as! PlayerViewController
                let albumImageView = sender?.view as! UIImageView
                if let index = coverImages.indexOf(albumImageView) {
                    let album = Album(index: index)
                    playerViewController.album = album
                    let x : Int = index+1
                    var imageIndex = String(x)
                    defaults.setObject("1" , forKey: "fromWhat")
                    defaults.setObject(imageIndex , forKey: "imageIndex")
                    defaults.synchronize()
                    //albumViewController.tempNumber = index
                }
                break;
            case "RecognizeSegue" :
                _ = segue.destinationViewController as! RecognizeViewController
                break;
            case "UploadSegue" :
                _ = segue.destinationViewController as! UploadViewController
                break;
            case "LoginSegue" :
                _ = segue.destinationViewController as! LoginViewController
                break;
            case "ProfileSegue" :
                _ = segue.destinationViewController as! ProfileViewController
                break;
            case "SearchSegue" :
                _ = segue.destinationViewController as! UINavigationController
                break;
            default:
                break;
            }
        }
    }
    
    
    // MARK : - Target / Action
    @IBAction func showAlbum(sender: UITapGestureRecognizer) {
        print("[SEGUE] TO PLAYER");
        self.performSegueWithIdentifier("PlaySegue", sender: sender)
    }
    
    @IBAction func cameraBtnClicked(sender: UIButton) {
        print("[SEGUE] TO RECOGNIZE");
        self.performSegueWithIdentifier("RecognizeSegue", sender: sender)
    }
    
    @IBAction func uploadBtnClicked(sender: UIButton) {
        if (defaults.objectForKey("username") == nil) {
            print("[SEGUE] NO USER");
        } else {
            print("[SEGUE] TO UPLOAD");
            self.performSegueWithIdentifier("UploadSegue", sender: sender)
        }
    }
    
    @IBAction func searchBtnClicked(sender: UIButton) {
        if (defaults.objectForKey("username") == nil) {
            print("[SEGUE] NO USER");
        } else {
            print("[SEGUE] TO SEARCH");
            self.performSegueWithIdentifier("SearchSegue", sender: sender)
        }
    }
    
    @IBAction func profileBtnClicked(sender: UIButton) {
        
        
        if (defaults.objectForKey("username") == nil) {
            
            print("[SEGUE] TO LOGIN");
            self.performSegueWithIdentifier("LoginSegue", sender: sender)
        } else {
            print("[SEGUE] TO PROFILE");
            self.performSegueWithIdentifier("ProfileSegue", sender: sender)
        }
        
    }
    
    @IBAction func nowplayingBtnClicked(sender: UIButton) {
        if sender.currentImage == UIImage(named:"music-folder-white"){
            
            sender.setImage(UIImage(named:"music-folder"), forState: UIControlState.Normal)
        } else if sender.currentImage == UIImage(named:"music-folder") {
            
            sender.setImage(UIImage(named:"music-folder-white"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func playBtnClicked(sender: UIButton) {
        if sender.currentImage == UIImage(named:"play"){
            player!.play()
            sender.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
        } else if sender.currentImage == UIImage(named:"pause") {
            player!.pause()
            sender.setImage(UIImage(named:"play"), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func nextBtnClicked(sender: UIButton) {
    //    performSegueWithIdentifier("Recognize", sender: sender)
    }
    
}



