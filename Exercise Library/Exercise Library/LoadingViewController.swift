//
//  LoadingViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/27/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var networkConnectionLabel: UILabel!
    override func viewDidLoad() {

        super.viewDidLoad()
        self.tryFetch()

    }
    
    func tryFetch() {
        networkConnectionLabel.hidden = true
        spinner.hidden = false
        label.hidden = false
        retryButton.hidden = true
        spinner.startAnimating()
        var beginLoadingClient = ExerciseLibraryClient.sharedInstance
        if(!beginLoadingClient.initialized){
            beginLoadingClient.fetch(self.continueFlow, self.errorFlow)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func continueFlow() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("NavigationController") as UIViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    func errorFlow() {
        spinner.hidden = true
        label.hidden = true
        retryButton.hidden = false
        networkConnectionLabel.hidden = false
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        self.tryFetch()
    }
}
