//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Vasyl Kotsiuba on 2/8/16.
//  Copyright © 2016 Vasiliy Kotsiuba. All rights reserved.
//

import UIKit

extension UIImageView {
  func loadImageWithURL(url: NSURL) -> NSURLSessionDownloadTask {
    let session = NSURLSession.sharedSession()
    
    let downloadTask = session.downloadTaskWithURL(url) { [weak self] (url, response, error) -> Void in
      if error == nil, let url = url, data = NSData(contentsOfURL: url), image = UIImage(data: data) {
        dispatch_async(dispatch_get_main_queue()) {
          if let strongSelf = self {
            strongSelf.image = image
          }
        }
      }
    }
    
    downloadTask.resume()
    return downloadTask
  }
}
