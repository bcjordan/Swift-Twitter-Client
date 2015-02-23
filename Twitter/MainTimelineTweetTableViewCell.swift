//
//  MainTimelineTweetTableViewCell.swift
//  Twitter
//
//  Created by Brian Jordan on 2/22/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class MainTimelineTweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetImage: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var tweetId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setNeedsLayout()
        setNeedsUpdateConstraints()
        layoutIfNeeded()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(tweet: Tweet) {
        if let user = tweet.user {
            tweetImage.setImageWithURL(NSURL(string: user.profileImageUrl!))
            usernameLabel.text = user.screenname

        }
        
        timestampLabel.text = tweet.createdAtString
        tweetTextLabel.text = tweet.text
        
        tweetId = tweet.tweetId
    }

    @IBAction func pressRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetId!){
            (error:NSError?) -> () in
            
            if (error == nil) {
                self.retweetButton.titleLabel?.text = "Retweeted"
            } else {
                println("Error: \(error)")
                self.retweetButton.titleLabel?.text = "Retweet Error"
            }
        }
    }
    
    @IBAction func pressFavorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweetId!){
            (error:NSError?) -> () in
            if (error == nil) {
                self.favoriteButton.titleLabel?.text = "Favorited"
            } else {
                println("Error: \(error)")
                self.favoriteButton.titleLabel?.text = "Favorite Error"
            }
        }
    }
}
