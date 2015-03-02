//
//  TwitterClient.swift
//  Twitter
//
//  Created by Brian Jordan on 2/22/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit


let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterAPISecret)
        }
        
        return Static.instance
    }
    
    func retweet(tweetId: String, completion: (error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(tweetId).json", parameters: nil, constructingBodyWithBlock: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            completion(error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error updating status")
                completion(error: error)
        }
    }
    
    func favorite(tweetId: String, completion: (error: NSError?) -> ()) {
        POST("1.1/favorites/create.json", parameters: ["id": tweetId], constructingBodyWithBlock: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            completion(error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error updating status")
                completion(error: error)
        }
    }
    
    func postTweet(contents: String, completion: (error: NSError?) -> () ) {
        POST("1.1/statuses/update.json", parameters: ["status": contents], constructingBodyWithBlock: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            completion(error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Error updating status")
                completion(error: error)
        }
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            var authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authUrl!)
            }) { (error: NSError!) -> Void in
                println("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println("home timeline: \(response)")
            
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operatioy6n: AFHTTPRequestOperation!, error: NSError!) -> Void in
                completion(tweets:nil, error: error)
        })
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                // println("user: \(response)")
                var user = User(dictionary: response as NSDictionary)
                User.currentUser = user
                
                // println("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
        }) { (error: NSError!) -> Void in
            println("Failed to receive access token")
            self.loginCompletion?(user: nil, error: error)
        }
    }
}
