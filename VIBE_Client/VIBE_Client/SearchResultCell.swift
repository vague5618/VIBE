//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Vasyl Kotsiuba on 2/5/16.
//  Copyright © 2016 Vasiliy Kotsiuba. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

  //MARK: - Outlets
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var artworkImageView: UIImageView!
  
  //MARK: - Ivars
  var downloadTask: NSURLSessionDownloadTask?
  
  //MARK: - View life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    let selectedView = UIView(frame: CGRect.zero)
    selectedView.backgroundColor = UIColor.appBluishGreenTinColor()
    selectedBackgroundView = selectedView
  }

  func configureForSearchResult(searchResult: SearchResult) {
    nameLabel.text = searchResult.name
    
    if searchResult.artistName.isEmpty {
      artistNameLabel.text = NSLocalizedString("Unknown", comment: "No artist found label")
    } else {
      artistNameLabel.text = String(format: NSLocalizedString("ARTIST_NAME_LABEL_FORMAT", comment: "Format for artist name label"), searchResult.artistName, searchResult.kindForDisplay())
    }
    
    artworkImageView.image = UIImage(named: "Placeholder")
    if let url = NSURL(string: searchResult.artworkURL60) {
      downloadTask = artworkImageView.loadImageWithURL(url)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    downloadTask?.cancel()
    downloadTask = nil
    
    nameLabel.text = nil
    artistNameLabel.text = nil
    artworkImageView.image = nil
  }
}
