//
//  VideoListViewController.swift
//  PiPVideoPlayer
//
//  Created by Alfian Losari on 1/19/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

class VideoListViewController: UITableViewController {
    
    var videoPlayer = PIPVideoPlayer()
    
    // Please use url link with mp4 video
    var sections: [(title: String, movies: [Video])] = [
        (title: "", movies: [
             Video(title: "", description: "", urlText: ""),
             Video(title: "", description: "", urlText: "")
        ]),
        (title: "", movies: [
            Video(title: "", description: "", urlText: ""),
            Video(title: "", description: "", urlText: "")
        ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let video = sections[indexPath.section].movies[indexPath.row]
        cell.textLabel?.text = video.title
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let video = sections[indexPath.section].movies[indexPath.row]
        guard let url = video.url else {
            return
            
        }
        videoPlayer.showVideo(url: url, in: self.view)
    }
}
