//
//  TimelineTweetViewController.swift
//  Twitter
//
//  Created by Brian Jordan on 2/22/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class TimelineTweetViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tweetTimestamp: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if tweet != nil {
            println("Tweet is \(tweet)")
        }
        if let user = tweet?.user {
            if let profileImageUrl = user.profileImageUrl {
                var url: NSURL = NSURL(string: profileImageUrl)!
                println("URL: \(url)")
                                self.userImage.setImageWithURL(url)
            }
                        usernameLabel.text = user.screenname
            
        }
        
        if let tweet = tweet {
            tweetTimestamp.text = tweet.createdAtString
            tweetText.text = tweet.text
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func retweetPressed(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet!.tweetId!, completion: { (error) -> () in
            if (error == nil) {
                self.retweetButton.titleLabel?.text = "Retweeted"
            } else {
                self.retweetButton.titleLabel?.text = "RT Error"
            }
        })
    }
    
    @IBAction func favoritePressed(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet!.tweetId!, completion: { (error) -> () in
            if (error == nil) {
                self.favoriteButton.titleLabel?.text = "Favorited"
            } else {
                self.favoriteButton.titleLabel?.text = "Fav Error"
            }
        })
    }
    
    func setTweet(newTweet: Tweet) {
        tweet = newTweet
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
