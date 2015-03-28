//
//  MuscleBrowseTableViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/27/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class MuscleBrowseTableViewController: UITableViewController {
    
    var junkItems = ["item1", "item2", "item3", "item4"]
    var muscleArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var beginLoadingClient = ExerciseLibraryClient.sharedInstance
        if(!beginLoadingClient.initialized){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("LoadingViewController") as LoadingViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
        } else {
            self.muscleArray = beginLoadingClient.allData["muscle_groups"] as NSArray
            println(self.muscleArray.count)
            /// var something: NSDictionary = beginLoadingClient.allData
        }
        

        /*
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(“LoginViewController”) as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
        */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.junkItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("muscleTableCell", forIndexPath: indexPath) as MuscleTableViewCell
        cell.configure(junkItems[indexPath.row])

        return cell
    }
    



}
