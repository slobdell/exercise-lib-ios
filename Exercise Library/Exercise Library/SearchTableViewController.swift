//
//  SearchTableViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/27/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    //var junkItems = ["item1", "item2", "item3", "item4", "item5"]
    var exerciseSearchResults:[NSDictionary] = []
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.hidden = true
    }
    func searchBar(_searchBar: UISearchBar,
        textDidChange searchText: String){
            
            //http://exercise-library.herokuapp.com/api/autocomplete/?q=test
            self.search(searchText.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "%20") )
    }
    
    func search(searchText:NSString) {
        let manager = AFHTTPRequestOperationManager()
        self.spinner.startAnimating()
        self.spinner.hidden = false
        manager.GET(
            "http://exercise-library.herokuapp.com/api/verbose_autocomplete/?q=\(searchText)",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                self.exerciseSearchResults = responseObject as [NSDictionary]
                self.tableView.reloadData()
                self.spinner.stopAnimating()
                self.spinner.hidden = true
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
                self.spinner.stopAnimating()
                self.spinner.hidden = true
            }
        )
    }
    
    func searchBarSearchButtonClicked(_searchBar: UISearchBar){
        self.searchBar.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.exerciseSearchResults.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("searchTableCell", forIndexPath: indexPath) as SearchResultTableViewCell
        cell.configure(exerciseSearchResults[indexPath.row])
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if(sender.tag == 99){
            super.prepareForSegue(segue, sender: sender)
        } else {
            var destinationViewController:ExerciseViewController = segue.destinationViewController as ExerciseViewController
            var view = self.tableView as UITableView
            var index = view.indexPathForSelectedRow()?.row
            var exerciseDict = self.exerciseSearchResults[index!] as NSDictionary
            destinationViewController.exercise = exerciseDict
            
            
        }
        
    }

}
