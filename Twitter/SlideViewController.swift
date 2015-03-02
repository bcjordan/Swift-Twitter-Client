//
//  SlideViewController.swift
//  Twitter
//
//  Created by Brian Jordan on 3/1/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit



class SlideViewController: UIViewController, MainViewControllerDelegate, SlideNavigationDelegate, UIGestureRecognizerDelegate {
    var mainViewCtrl: TweetsViewController?
    var menuViewCtrl: MenuViewController?
    var currentState: UIGestureRecognizerState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("TweetsViewController") as? TweetsViewController
        
        mainViewCtrl?.delegate = self
        addMainView()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
        case UIGestureRecognizerState.Began:
            self.toggleMenu()
//        case UIGestureRecognizerState.Changed:
//            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
//            recognizer.setTranslation(CGPointZero, inView: view)
//        case UIGestureRecognizerState.Ended:
//            
        default:
            break
        }
    }
    
    func addMainView(){
        self.view.addSubview(mainViewCtrl!.view)
        self.addChildViewController(mainViewCtrl!)
        mainViewCtrl!.didMoveToParentViewController(self)
    }
    
    func toggleMenu() {
        if(menuViewCtrl == nil){
            menuViewCtrl = self.storyboard?.instantiateViewControllerWithIdentifier("menuVC") as? MenuViewController
            menuViewCtrl?.delegate = self
            
            self.view.insertSubview(menuViewCtrl!.view, atIndex: 0)
            self.addChildViewController(menuViewCtrl!)
            menuViewCtrl?.didMoveToParentViewController(mainViewCtrl)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.mainViewCtrl!.view.frame.origin.x = self.mainViewCtrl!.view.frame.width - 50
                }, completion: nil)
        }else{
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.mainViewCtrl!.view.frame.origin.x = 0
                }, completion: {
                    finished in
                    
                    self.menuViewCtrl!.view.removeFromSuperview()
                    self.menuViewCtrl!.removeFromParentViewController()
                    self.menuViewCtrl = nil
            })
        }
    }
    
    func goToTimeline() {
        self.toggleMenu()
    }
    
    func goToProfile() {
        self.toggleMenu()
    }
    
    func goToMentions() {
        self.toggleMenu()
    }
}
