//
//  AlbumViewController.swift
//  wave
//
//  Created by ndvor on 3/17/16.
//  Copyright © 2016 ndvor. All rights reserved.
//  2016. 05. 01
//

import UIKit
import Alamofire
import SwiftyJSON
import Toast_Swift

class AlbumViewController: UIViewController {
    
    // Model : an album
    var album: Album = Album(index: 1)
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // Update the UI with the model
    func updateUI() {
        let albumName = "\((album.coverImageName)!)"
        print(albumName)
        backgroundImageView?.image = UIImage(named: albumName)
        albumCoverImageView?.image = UIImage(named: albumName)
        
        let songList = ((album.songs)! as NSArray).componentsJoinedByString(", ")
        descriptionTextView.text = "\((album.description)!) \n\nSome songs in the album:\n\(songList)"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // can only updateUI once the view is loaded meaning that all the properties and outlets wer just set
        // If they are not set, they are nil. Sending methods to nil object will crash your program
        title = "Album"
        updateUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Gets the backgroud image out of the wat when the view disappears
        backgroundImageView?.removeFromSuperview()
        
    }
}





