//
//  FinalTableViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/29/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class FinalTableViewController: UITableViewController {
    var muscleTree = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return self.muscleTree.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("muscle3TableCell", forIndexPath: indexPath) as Muscle3TableViewCell
        cell.configure(self.muscleTree[indexPath.row] as NSArray)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if(sender.tag == 99){
            super.prepareForSegue(segue, sender: sender)
        } else {
            println("CP1")
            var destinationViewController:FilterViewController = segue.destinationViewController as FilterViewController
            
            var view = self.view as UITableView
            var index = view.indexPathForSelectedRow()?.row
            let muscleId = self.muscleTree[index!][0] as Int
            destinationViewController.muscleId = muscleId
            println("END")
        }
        
    }

}
