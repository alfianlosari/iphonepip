//
//  Video.swift
//  PiPVideoPlayer
//
//  Created by Alfian Losari on 1/19/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

// Please use url link with mp4 video
struct Video {
    
    let title: String
    let description: String
    let urlText: String
    
    var url: URL? {
        guard let url = URL(string: urlText) else {
            return nil
        }
        return url
    }
}
