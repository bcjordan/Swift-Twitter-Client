//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Brian Jordan on 2/22/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContents: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Compose"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tweet", style: .Plain, target: self, action: "pressTweet")

        userImage.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!))
        usernameLabel.text = User.currentUser?.screenname
        
        // Do any additional setup after loading the view.
    }
    
    func pressTweet() {
        println("Tweeting with text \(tweetContents.text)")
        TwitterClient.sharedInstance.postTweet(tweetContents.text) {
            (error: NSError?) -> () in
            if (error != nil) {
                println(error)
            } else {
                self.tweetContents.text = "TWEET COMPLETE"
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
