//
//  MenuViewController.swift
//  Twitter
//
//  Created by Brian Jordan on 3/1/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

protocol SlideNavigationDelegate: class {
    func goToTimeline()
    func goToProfile()
    func goToMentions()
}

class MenuViewController: UIViewController {

    var delegate: SlideNavigationDelegate?
    
    @IBAction func timelinePress(sender: AnyObject) {
        print("timeline press")
        delegate?.goToTimeline()
    }
    @IBAction func profilePress(sender: AnyObject) {
        print("profile press")
        delegate?.goToProfile()
    }
    @IBAction func mentionsPress(sender: AnyObject) {
        print("mentions press")
        delegate?.goToMentions()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
