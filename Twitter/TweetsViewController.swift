//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Brian Jordan on 2/22/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        refreshTweets()
        tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull for Fresh Tweets")
        self.refreshControl.addTarget(self, action: "refreshTweets", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tweet", style: .Plain, target: self, action: "pressComposeTweet")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "pressLogout")
        self.navigationItem.title = "Timeline"
    }
    
    func pressComposeTweet() {
        performSegueWithIdentifier("composeTweet", sender: self)
    }
    
    func pressLogout() {
        User.currentUser?.logout()
    }
    
    func refreshTweets() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let vc = self.tableView.dequeueReusableCellWithIdentifier("MainTimelineTweetTableViewCell") as MainTimelineTweetTableViewCell
        if let tweet = tweets?[indexPath.row] {
            vc.setTweet(tweet)
        }

        return vc
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "DetailSegue" == segue.identifier {
            var vc = segue.destinationViewController as TimelineTweetViewController
            if let tweet = tweets?[tableView.indexPathForSelectedRow()!.row] {
                vc.setTweet(tweet)
            }
        }
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
