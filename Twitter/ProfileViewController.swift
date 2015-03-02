//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Brian Jordan on 3/1/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowersLAbel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = user?.screenname
        numTweetsLabel.text = user?.tweetsCount
        numFollowersLAbel.text = user?.followersCount
        numFollowingLabel.text = user?.friendsCount
        if let profileImageUrl = user?.profileImageUrl {
            var url: NSURL = NSURL(string: profileImageUrl)!
            println("URL: \(url)")
            self.profileImageView.setImageWithURL(url)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setUser(user: User) {
        self.user = user
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
