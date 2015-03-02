//
//  SlideViewController.swift
//  Twitter
//
//  Created by Brian Jordan on 3/1/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit



class SlideViewController: UIViewController, MainViewControllerDelegate, SlideNavigationDelegate, UIGestureRecognizerDelegate {
    var mainViewCtrl: UINavigationController?
    var menuViewCtrl: MenuViewController?
    var currentState: UIGestureRecognizerState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as? UINavigationController
        
        if User.currentUser != nil {
            goToMentions()
        } else {
            goToLogin()
        }

        addMainView()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userLoggedIn", name: "userLoggedIn", object: nil)
    }
    
    func goToLogin() {
        mainViewCtrl?.pushViewController(self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController, animated: false)
    }
    
    func userLoggedIn() {
        mainViewCtrl?.popToRootViewControllerAnimated(false)
    }
    
    func userDidLogout() {
        goToLogin()
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizerState.Began) {
            self.toggleMenu()
        }
    }
    
    func addMainView(){
        self.view.addSubview(mainViewCtrl!.view)
        self.addChildViewController(mainViewCtrl!)
        mainViewCtrl!.didMoveToParentViewController(self)
    }
    
    // Toggles a dedicated menu view sliding in and out
    // Kudos to Anoop Tomar for sharing his technique for slide-in view management on the Facebook group
    func toggleMenu() {
        if (menuViewCtrl == nil) {
            menuViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("menuVC") as? MenuViewController
            menuViewCtrl?.delegate = self
            
            self.view.insertSubview(menuViewCtrl!.view, atIndex: 0)
            self.addChildViewController(menuViewCtrl!)
            menuViewCtrl?.didMoveToParentViewController(mainViewCtrl)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    self.mainViewCtrl!.view.frame.origin.x = self.mainViewCtrl!.view.frame.width - 50
                }, completion: nil)
        } else {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    self.mainViewCtrl!.view.frame.origin.x = 0
                }, completion: {
                    finished in
                    
                    if (self.menuViewCtrl != nil) {
                        self.menuViewCtrl!.view.removeFromSuperview()
                        self.menuViewCtrl!.removeFromParentViewController()
                        self.menuViewCtrl = nil
                    }
            })
        }
    }
    
    func goToTimeline() {
        if (mainViewCtrl?.topViewController is TweetsViewController) {
        } else {
            mainViewCtrl?.popToRootViewControllerAnimated(true)
        }
        
        var tweetsController = mainViewCtrl?.topViewController as TweetsViewController
        tweetsController.setTweetsToShow("timeline")
        self.toggleMenu()
    }
    
    func goToProfile() {
        mainViewCtrl?.popToRootViewControllerAnimated(true)
        var profileViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileViewController") as ProfileViewController
        profileViewController.setUser(User.currentUser!)
        mainViewCtrl?.pushViewController(profileViewController, animated: true)
        self.toggleMenu()
    }
    
    func goToMentions() {
        if (mainViewCtrl?.topViewController is TweetsViewController) {
            
        } else {
            mainViewCtrl?.popToRootViewControllerAnimated(true)
        }
        
        var tweetsController = mainViewCtrl?.topViewController as TweetsViewController
        tweetsController.setTweetsToShow("mentions")
        self.toggleMenu()
    }
}
