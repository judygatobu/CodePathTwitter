//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoritecountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            
            tweetTextLabel.text = tweet.user.name
            
            screenNameLabel.text = "@\(tweet.user.screenName)"
            
            profileImageView.af_setImage(withURL: URL(string: tweet.user.imageURL)!)
            
            timeStampLabel.text = tweet.createdAtString
            
            tweetTextLabel.text = tweet.text
            
            if (tweet.retweetCount == 0)
            {
                tweetTextLabel.text = " "
            } else {
                tweetTextLabel.text = String(tweet.retweetCount)
            }
            
            if (tweet.favoriteCount == 0)
            {
                favoritecountLabel.text = " "
            } else {
                favoritecountLabel.text = String(describing: tweet.favoriteCount)
            }
            
            if (tweet.retweeted == true)
            {
                retweetButton.isSelected = true
            } else {
                retweetButton.isSelected = false
            }
            
            if (tweet.favorited == true)
            {
                favoriteButton.isSelected = true
            } else {
                favoriteButton.isSelected = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.masksToBounds = true;
        profileImageView.layer.cornerRadius = 30
        
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
        if (retweetButton.isSelected != true) {
            
            retweetButton.isSelected = true
            tweet.retweeted = true
            tweet.retweetCount += 1
            self.tweetTextLabel.text = String(tweet.retweetCount)
            
            //APIManager Request from Cell
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error Retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        } else if (retweetButton.isSelected == true) {
            retweetButton.isSelected = false
            tweet.retweeted = false
            tweet.retweetCount -= 1
            self.tweetTextLabel.text = String(tweet.retweetCount)
            
            //APIManager Request from Cell
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error UnRetweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        
        if (favoriteButton.isSelected != true) {
            
            favoriteButton.isSelected = true
            tweet.favorited = true
            tweet.favoriteCount! += 1
            self.favoritecountLabel.text = String(tweet.favoriteCount!)
            
            //APIManager Request from Cell
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else if (favoriteButton.isSelected == true) {
            favoriteButton.isSelected = false
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            self.favoritecountLabel.text = String(describing: tweet.favoriteCount)
            
            //APIManager Request from Cell
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



