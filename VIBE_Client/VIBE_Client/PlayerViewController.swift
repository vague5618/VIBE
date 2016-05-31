//
//  PlayerViewController.swift
//  wave
//
//  Created by ndvor on 3/19/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Alamofire
import SwiftyJSON
import Toast_Swift
import KDEAudioPlayer

class PlayerViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    // Model : an album
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var myVolumeController: UISlider!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topLabel2: UILabel!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var gotoListBtn: UIButton!
    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var loopBtn: UIButton!
    @IBOutlet weak var shffleBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    @IBOutlet weak var equaView: UIView!
    
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var dislikeNum: UILabel!
    var param = [
        "id": ""
    ]
    let defaults = `NSUserDefaults`.standardUserDefaults()
    
    var album: Album = Album(index: 1)
    //var playerItem:AVPlayerItem!
    var player:AVAudioPlayer!
    
    var idNames:[String] = []
    var MusicNames:[String] = []
    var SingerNames:[String] = []
    var PathNames:[String] = []
    var lyrics:[String] = []
    var url = Url()
    //var delegate : playControllerDelegate?
    let basicListId = ["5749233203efcd84151a7a24","5749233203efcd84151a7a25","5749233203efcd84151a7a27",
                       "5749233203efcd84151a7a29","5749233203efcd84151a7a26","5749233203efcd84151a7a28",
                       "5749233203efcd84151a7a2a","5749233203efcd84151a7a2b","5749233203efcd84151a7a2c"
    ]
    let recognizListId = ["1","2","3","4","5","6","7","8","9"]
    
    override func viewDidLoad() {
        title = "Play"
        inits()
        updateList()
        
        super.viewDidLoad()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //Gets the backgroud image out of the wat when the view disappears
        //backgroundImageView?.removeFromSuperview()
    }
    
    //About Table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.myTable.dequeueReusableCellWithIdentifier("celler", forIndexPath:  indexPath) as! PlayerTableViewCell
        cell.topLabel.text = MusicNames[indexPath.row]
        cell.bottomLabel.text = SingerNames[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        startMusic(idNames[indexPath.row])
        changeMain(MusicNames[indexPath.row],target2: SingerNames[indexPath.row] , target3 : lyrics[indexPath.row])
    }
    
    func inits() {
        let fromWhat = defaults.objectForKey("fromWhat") as! String
        let imageIndex = defaults.objectForKey("imageIndex") as! String
        var selectVal = " "
        print("fromWhat=\(fromWhat)")
        print("imageIndex=\(imageIndex)")
        topLabel.text = " "
        topLabel2.text = " "
        var albumName = "\((album.coverImageName)!)"
        
        if(fromWhat == "1") {
           
            switch imageIndex {
            case "1":
                selectVal = basicListId[0]
                break;
            case "2":
                selectVal = basicListId[1]
                break;
            case "3":
                selectVal = basicListId[2]
                break;
            case "4":
                selectVal = basicListId[3]
                break;
            case "5":
                selectVal = basicListId[4]
                break;
            case "6":
                selectVal = basicListId[5]
                break;
            case "7":
                selectVal = basicListId[6]
                break;
            case "8":
                selectVal = basicListId[7]
                break;
            case "9":
                selectVal = basicListId[8]
                break;
            default:
                break;
            }

        } else if (fromWhat == "2") {
            switch imageIndex {
            case "1":
                selectVal = recognizListId[0]
                break;
            case "2":
                selectVal = recognizListId[1]
                break;
            case "3":
                selectVal = recognizListId[2]
                break;
            case "4":
                selectVal = recognizListId[3]
                break;
            case "5":
                selectVal = recognizListId[4]
                break;
            case "6":
                selectVal = recognizListId[5]
                break;
            case "7":
                selectVal = recognizListId[6]
                break;
            case "8":
                selectVal = recognizListId[7]
                break;
            case "9":
                selectVal = recognizListId[8]
                break;
            default:
                break;
            }
            albumName = selectVal
        } else {
            NSLog("[!] Invalid Access")
        }
        param = [
            "id": selectVal
        ]
        
        descriptionTextView.hidden = true
        topLabel.hidden = true
        topLabel2.hidden = true
        equalButton.hidden = true
        equaView.hidden = true
        likeNum.hidden = true
        dislikeNum.hidden = true
        
        backgroundImageView?.image = UIImage(named: albumName)
        albumCoverImageView?.image = UIImage(named: albumName)
        
        //let songList = ((album.songs)! as NSArray).componentsJoinedByString(", ")
        //descriptionTextView.text = "\((album.description)!) \n\nSome songs in the album:\n\(songList)"
        
        //if ((player!.playing)) {
        //    playButton.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
        //}
        
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
    
    func updateList () {
        
        Alamofire.request(.POST, url.listReadUrl, parameters: param)
            .responseJSON {
                response in
                if(response.result.value != nil) {
                    let list_val = JSON(response.result.value!)
                    var index = 0
                    //getMusic
                    for _ in list_val[0]["musicArray"] {
                        let music = [
                            "id": list_val[0]["musicArray"][index].stringValue
                        ]
                        
                        Alamofire.request(.POST, self.url.musicReadUrl, parameters: music)
                            .responseJSON {
                                response in
                                
                                if(response.result.value != nil) {
                                    let music_val = JSON(response.result.value!)
                                    //print(music_val[0]["musicName"].stringValue + music_val[0]["singerName"].stringValue)
                                    
                                    self.idNames.append(music_val[0]["_id"].stringValue)
                                    self.MusicNames.append(music_val[0]["musicName"].stringValue)
                                    self.SingerNames.append(music_val[0]["singerName"].stringValue)
                                    self.PathNames.append(music_val[0]["pathName"].stringValue)
                                    self.lyrics.append(music_val[0]["lyrics"].stringValue)
                                    self.myTable.reloadData()
                                    //print(self.idNames)
                                    //print(self.MusicNames)
                                    //print(self.SingerNames)
                                    //print(self.PathNames)
                                }
                        }
                        index += 1;
                    }
                }
                
        }
        
    }
    
    func playBackgroundMusic(fileId : String) {
        
        do {
            let soundURL: NSURL = NSURL(string: url.musicStartUrl+fileId)!
            let soundData = NSData(contentsOfURL: soundURL)
            player = try AVAudioPlayer(data: soundData!)
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func startMusic(target : String) {
        
        playBackgroundMusic(target)
        player.rate = 1.0;
        progressSlider.maximumValue = Float(player.duration)
        
        if playButton.currentImage == UIImage(named:"play"){
            player.play()
            playButton.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
        } else if playButton.currentImage == UIImage(named:"pause") {
            player.stop()
            playButton.setImage(UIImage(named:"play"), forState: UIControlState.Normal)
        }
        
        _ = NSTimer.scheduledTimerWithTimeInterval(0.1 ,target: self, selector: #selector(PlayerViewController.updateSlider), userInfo:nil, repeats: true)
        
        
    }
    
    
    func changeMain(target : String, target2 : String, target3 : String) {
        topLabel.text = target
        topLabel2.text = target2
        descriptionTextView.text = target3
    }
    
    func updateSlider(){
        progressSlider.value = Float(player!.currentTime)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Play2Login" :
                _ = segue.destinationViewController as! LoginViewController
                break;
            case "Play2Profile" :
                _ = segue.destinationViewController as! ProfileViewController
                break;
            case "Play2Search" :
                _ = segue.destinationViewController as! UINavigationController
                break;
            default:
                break;
            }
        }
    }
    
    //About Play Audio.
    @IBAction func playAudio(sender: UIButton) {
        
        if sender.currentImage == UIImage(named:"play"){
            player.play()
            sender.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
        } else if sender.currentImage == UIImage(named:"pause") {
            player.pause()
            sender.setImage(UIImage(named:"play"), forState: UIControlState.Normal)
        }
    }
    // Volume Control
    @IBAction func controlVolume(sender: AnyObject) {
        player.volume =  myVolumeController.value
    }
    
    @IBAction func listButtonTapped(sender: UIButton) {
        if sender.currentImage == UIImage(named:"music-folder-white"){
            myTable.hidden = false
            topView.hidden = false
            equaView.hidden = true
            descriptionTextView.hidden = true
            topLabel.hidden = true
            topLabel2.hidden = true
            equalButton.hidden = true
            
            sender.setImage(UIImage(named:"music-folder"), forState: UIControlState.Normal)
        } else if sender.currentImage == UIImage(named:"music-folder") {
            myTable.hidden = true
            topView.hidden = true
            descriptionTextView.hidden = false
            topLabel.hidden = false
            topLabel2.hidden = false
            equalButton.hidden = false
            
            sender.setImage(UIImage(named:"music-folder-white"), forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func searchBtnClicked(sender: UIButton) {
        print("[CLICK] SEARCH BUTTON")
        if (defaults.objectForKey("username") == nil) {
            print("[SEGUE] NO USER");
        } else {
            print("[SEGUE] TO SEARCH");
            self.performSegueWithIdentifier("Play2Search", sender: sender)
        }
    }
    
    
    @IBAction func profBtnClicked(sender: UIButton) {
        
        print("[CLICK] PROFILE BUTTON")
        if (defaults.objectForKey("username") == nil) {
            print("[SEGUE] TO LOGIN");
            self.performSegueWithIdentifier("Play2Login", sender: sender)
        } else {
            print("[SEGUE] TO PROFILE");
            self.performSegueWithIdentifier("Play2Profile", sender: sender)
        }
    }
    
    @IBAction func loopBtnClicked(sender: UIButton) {
        print("[CLICK] LOOP BUTTON")
        if (defaults.objectForKey("username") == nil) {
            print("[FUNC] NO USER");
        } else {
            
            if sender.currentImage == UIImage(named:"repeat-black"){
                sender.setImage(UIImage(named:"repeat-white"), forState: UIControlState.Normal)
                
            } else if sender.currentImage == UIImage(named:"repeat-white") {
                sender.setImage(UIImage(named:"repeat_only_one"), forState: UIControlState.Normal)
                player.numberOfLoops = -1;
            } else if sender.currentImage == UIImage(named:"repeat_only_one") {
                sender.setImage(UIImage(named:"repeat-black"), forState: UIControlState.Normal)
                player.numberOfLoops = 0;
            }
            
        }
    }
    
    @IBAction func shuffleBtnClicked(sender: UIButton) {
        print("[CLICK] SHUFFLE BUTTON")
        if (defaults.objectForKey("username") == nil) {
            print("[FUNC] NO USER");
        } else {
            if sender.currentImage == UIImage(named:"shuffle-black"){
                sender.setImage(UIImage(named:"shuffle-white"), forState: UIControlState.Normal)
            } else if sender.currentImage == UIImage(named:"shuffle-white") {
                sender.setImage(UIImage(named:"shuffle-black"), forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func equaBtnClicked(sender: UIButton) {
        print("[CLICK] EQ BUTTON")
        if (defaults.objectForKey("username") == nil) {
            print("[FUNC] NO USER");
        } else {if sender.currentImage == UIImage(named:"equal_black"){
            equaView.hidden = true
            
            sender.setImage(UIImage(named:"equal_white"), forState: UIControlState.Normal)
        } else if sender.currentImage == UIImage(named:"equal_white") {
            equaView.hidden = false
            
            sender.setImage(UIImage(named:"equal_black"), forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func selectTime(sender: AnyObject) {
        
        player.stop()
        player.currentTime = NSTimeInterval(progressSlider.value)
        player.prepareToPlay()
        
        if playButton.currentImage == UIImage(named:"play"){
            player.play()
            playButton.setImage(UIImage(named:"pause"), forState: UIControlState.Normal)
        } else if playButton.currentImage == UIImage(named:"pause") {
            player.play()
        }
        
    }
    
    @IBAction func menuBtnClicked(sender: UIButton) {
        if sender.currentImage == UIImage(named:"menu-black"){
            sender.setImage(UIImage(named:"menu-white"), forState: UIControlState.Normal)
        } else if sender.currentImage == UIImage(named:"menu-white") {
            sender.setImage(UIImage(named:"menu-black"), forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func likeBtnClicked(sender: UIButton) {
        print("[CLICK] LIKE BUTTON")
        if (defaults.objectForKey("username") == nil) {
            print("[FUNC] NO USER");
        } else {
            if sender.currentImage == UIImage(named:"like-black"){
                sender.setImage(UIImage(named:"like-white"), forState: UIControlState.Normal)
                dislikeNum.hidden = true
                dislikeBtn.hidden = true
                likeNum.hidden = false
            } else if sender.currentImage == UIImage(named:"like-white") {
                sender.setImage(UIImage(named:"like-black"), forState: UIControlState.Normal)
                dislikeBtn.hidden = false
                likeNum.hidden = true
            }
        }
    }
    @IBAction func dislikeBtnClicked(sender: UIButton) {
        print("[CLICK] DISLIKE BUTTON")
        if (defaults.objectForKey("username") == nil) {
            print("[FUNC] NO USER");
        } else {
            if sender.currentImage == UIImage(named:"dislike-black"){
                sender.setImage(UIImage(named:"dislike-white"), forState: UIControlState.Normal)
                likeNum.hidden = true
                likeBtn.hidden = true
                dislikeNum.hidden = false
            } else if sender.currentImage == UIImage(named:"dislike-white") {
                sender.setImage(UIImage(named:"dislike-black"), forState: UIControlState.Normal)
                likeBtn.hidden = false
                dislikeNum.hidden = true
            }
        }
        
    }
    
    
    /*
     @IBAction func pauseAudio(sender: AnyObject) {
     myAudioPlayer.pause()
     }
     
     @IBAction func stopAudio(sender: AnyObject) {
     myAudioPlayer.stop()
     myAudioPlayer.currentTime = 0
     }
     */
}


