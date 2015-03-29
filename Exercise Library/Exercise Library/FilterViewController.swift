//
//  FilterViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/29/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var muscleId:Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.muscleId)

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
