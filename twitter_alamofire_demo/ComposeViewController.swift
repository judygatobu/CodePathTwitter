//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Judy Gatobu on 4/7/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}


class ComposeViewController: UIViewController {

    
    weak var delegate: ComposeViewControllerDelegate?
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var tweetButton: UIButton!
    
    @IBOutlet weak var tweetText: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    
    let user = User.currentUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       // profileImageView.af_setImage(withURL:  tweet.user.profileImage!)

        profileImage.layer.masksToBounds = true;
        profileImage.layer.cornerRadius = 30;
        profileImage.af_setImage(withURL: (string: user.profileImage) as! URL)

        
        cancelButton.layer.masksToBounds = true;
        tweetButton.layer.masksToBounds = true;
        cancelButton.layer.cornerRadius = 15;
        tweetButton.layer.cornerRadius = 15;
        
        // Handle showing and hiding the keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShows), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHides), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
        
        
    }
    
    @objc func handleKeyboardShows(notification: NSNotification) {
        
        if (tweetText.text == "") || (tweetText.text == "What's Happening?") {
            tweetText.text = ""
        }
        
    }
    
    @objc func handleKeyboardHides(notification: NSNotification) {
        
        if tweetText.text == "" {
            tweetText.text = "What's Happening?"
        }
        
    }
    
    
        //cancelButton
        
        @IBAction func onCancel(_ sender: Any) {
            tweetText.text = "What's Happening?";
            
            self.dismiss(animated: true, completion: nil);
        }

        
       //tweetButton
        @IBAction func onTweet(_ sender: Any) {
            APIManager.shared.composeTweet(with: tweetText.text) { (tweet, error) in
                if let error = error {
                    print("Error composing Tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    self.delegate?.did(post: tweet)
                    print("Compose Tweet Success!")
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
