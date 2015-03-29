//
//  IntermediateTableViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/28/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class IntermediateTableViewController: UITableViewController {
    var muscleTree = []
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.muscleTree.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("muscle2TableCell", forIndexPath: indexPath) as Muscle2TableViewCell
        
        cell.configure(self.muscleTree[indexPath.row] as NSArray)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        var destinationViewController:FinalTableViewController = segue.destinationViewController as FinalTableViewController
        
        var view = self.view as UITableView
        var index = view.indexPathForSelectedRow()?.row
        let muscleList = self.muscleTree[index!][1] as NSArray
        destinationViewController.muscleTree = muscleList

    }


}
