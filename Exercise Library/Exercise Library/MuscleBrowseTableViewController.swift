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
    var muscleTree = []
    
    var muscleArray = [] // SBL left off here need to actually set an item here.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var beginLoadingClient = ExerciseLibraryClient.sharedInstance
        if(!beginLoadingClient.initialized){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("LoadingViewController") as LoadingViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
        } else {
            self.muscleTree = beginLoadingClient.allData["muscle_tree"] as NSArray
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
        return self.muscleTree.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("muscleTableCell", forIndexPath: indexPath) as MuscleTableViewCell
        
        cell.configure(self.muscleTree[indexPath.row] as NSArray)

        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {

        if(sender.tag == 99){
            super.prepareForSegue(segue, sender: sender)
        } else {
            var destinationViewController:IntermediateTableViewController = segue.destinationViewController as IntermediateTableViewController
            var view = self.view as UITableView
            var index = view.indexPathForSelectedRow()?.row
            let muscleList = self.muscleTree[index!][1] as NSArray
        destinationViewController.muscleTree = muscleList
        }
    }
    
    



}
