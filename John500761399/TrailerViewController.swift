//
//  TrailerViewController.swift
//  John500761399
//
//  Created by John Verdonck on 02/05/2019.
//  Copyright © 2019 John Verdonck. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import AVKit


class TrailerViewController: UIViewController {
    
    var movieObject: MovieObject?
    
    @IBAction func trailerButton(_ sender: Any) {
        if (movieObject?.url) != nil {
            let player = AVPlayer(url: movieObject!.url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        }
    }
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var stillImage: UIImageView!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movieObject?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("shareTitle", comment: ""), style: .plain, target: self, action: #selector(share(sender:)))
        trailerButton.setTitle(NSLocalizedString("trailerButtonTitle", comment:""), for: .normal)
        movieTitle.text = movieObject?.title
        
        movieTitle.font = UIFont.boldSystemFont(ofSize: 16.0)
        movieDescription.text = movieObject?.description
        movieDescription.isEditable = false
        
        if (movieObject?.posterImage) != nil {
            posterImage.kf.setImage(with: movieObject?.posterImage)
        }
        
        if (movieObject?.stillImage) != nil {
            stillImage.kf.setImage(with: movieObject?.stillImage)
        }
        
        
        
    }
    
    @objc func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = NSLocalizedString("shareText", comment: "") + movieObject!.title
            if let trailerURL = movieObject?.url {
            let objectsToShare = [textToShare, trailerURL, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }    }
}
