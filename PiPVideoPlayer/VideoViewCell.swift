//
//  VideoViewCell.swift
//  PiPVideoPlayer
//
//  Created by Alfian Losari on 1/20/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

class VideoViewCell: UITableViewCell {

    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var videoCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
