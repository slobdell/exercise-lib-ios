//
//  EquipmentViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 4/1/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class EquipmentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var equipmentList:NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        var client = ExerciseLibraryClient.sharedInstance
        self.equipmentList = client.allData["equipment"] as NSArray


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.equipmentList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("equipmentTableViewCell", forIndexPath: indexPath) as EquipmentTableViewCell
        cell.configure(self.equipmentList[indexPath.row] as NSDictionary)
        return cell
    }

}
