//
//  PIPVideoPlayer.swift
//  PiPVideoPlayer
//
//  Created by Alfian Losari on 1/19/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import AVFoundation

class PIPVideoPlayer: NSObject {
    
    private var currentView: UIView!
    private var currentURL: URL?
    private var avplayer: AVPlayer!
    private var avPlayerLayer: AVPlayerLayer!
    private var closeButton: UIButton?
    private var videoView: UIView!

    private var fullFrame: CGRect? {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return nil
        }
        
        let width = keyWindow.frame.width / 1.25
        let height = width * 9 / 16
        let fullFrame = CGRect(x: keyWindow.frame.width -  width - 32.0, y: keyWindow.frame.height - height - 32.0, width: width, height: height)
        return fullFrame
    }
    
    func showVideo(url: URL, in view: UIView) {
        setupVideoView()
        
        if let currentURL = currentURL, currentURL == url {
            return
        }
        
        self.currentURL = url
        self.currentView = view
        
        self.avplayer.pause()
        self.avplayer.replaceCurrentItem(with: AVPlayerItem(url: url))
        self.avplayer.play()
        
        if self.videoView.isHidden {
            self.showVideoView()
        }
    }
    
    private func setupVideoView() {
        guard self.videoView == nil else {
            return
        }

        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        let videoView = UIView()
        videoView.backgroundColor = .black
        videoView.layer.cornerRadius = 10.0
        videoView.layer.shadowColor = UIColor.black.cgColor
        videoView.layer.shadowOpacity = 1
        videoView.layer.shadowOffset = .zero
        videoView.layer.shadowRadius = 5
        
        self.avplayer = AVPlayer()
        self.avPlayerLayer = AVPlayerLayer(player: self.avplayer)
        videoView.layer.addSublayer(self.avPlayerLayer)
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDrag(_:)))
        recognizer.maximumNumberOfTouches = 1
        videoView.addGestureRecognizer(recognizer)
        
        
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Ｘ", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(self.handleCloseTapped(_:)), for: .touchUpInside)
        videoView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        closeButton.trailingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: -8.0).isActive = true
        closeButton.topAnchor.constraint(equalTo: videoView.topAnchor, constant: 8.0).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        videoView.isHidden = true

        keyWindow.addSubview(videoView)
        self.videoView = videoView
    }
    
    private func showVideoView(completion: ((Bool) -> Void)? = nil) {
        guard let fullFrame = self.fullFrame else {
            return
        }
        
        self.videoView.isHidden = false
        self.videoView.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
        self.closeButton?.alpha = 0.0

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.videoView.frame = fullFrame
            self.closeButton?.alpha = 1.0
            self.avPlayerLayer.frame = self.videoView.bounds
        }, completion: completion)
    }
    
    private func hideVideoView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.videoView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            self.closeButton?.alpha = 0
            self.avPlayerLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }, completion: { (_) in
            self.videoView.isHidden = true
            self.avplayer.pause()
            self.currentURL = nil
        })
    }
    
    @objc func handleCloseTapped(_ sender: Any) {
        self.hideVideoView()
    }
    
    @objc func handleDrag(_ sender: UIPanGestureRecognizer) {
        let screenBounds = UIScreen.main.bounds
        
        let translation = sender.translation(in: videoView)
        videoView.center = CGPoint(x: videoView.center.x + translation.x, y: videoView.center.y + translation.y)
        sender.setTranslation(CGPoint(x: 0, y: 0), in: videoView)
        
        if sender.state == .ended {
            var finalPoint = CGPoint(x: 0, y: 0)
            
            finalPoint.x = max(32 + videoView.frame.size.width, min(videoView.frame.maxX, screenBounds.size.width - 32.0))
            finalPoint.y = max(32 + videoView.frame.size.height ,min(videoView.frame.maxY, screenBounds.size.height - 32.0))
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.videoView.frame.origin = CGPoint(x: finalPoint.x - self.videoView.frame.size.width, y: finalPoint.y - self.videoView.frame.size.height)
            })
        }
    }
    
}
