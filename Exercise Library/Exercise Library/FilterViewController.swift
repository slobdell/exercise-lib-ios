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

    var baseMuscleList: [NSDictionary] = []


    @IBOutlet weak var exerciseTypeFilter: UISegmentedControl!
    override func viewDidLoad() {
        exerciseTypeFilter.removeAllSegments()
        var client = ExerciseLibraryClient.sharedInstance
        var exerciseTypes = client.allData["exercise_types"] as NSArray
        
        for exerciseTypeDict in exerciseTypes{
            var exerciseTypeDict = exerciseTypeDict as NSDictionary
            var id = exerciseTypeDict["id"] as Int
            var title = exerciseTypeDict["title"] as NSString
            exerciseTypeFilter.insertSegmentWithTitle(title, atIndex: id, animated: true)
        }
        
        self.baseMuscleList = [] // SBL not sure if this is necessary
        for exercise in client.allData["exercises"] as NSArray{
            var exercise = exercise as NSDictionary
            if(exercise["muscle_group_id"] as Int == self.muscleId){
                self.baseMuscleList.append(exercise)
            }
        }
        
        super.viewDidLoad()
    }
    @IBAction func exerciseTypeChanged(sender: UISegmentedControl) {
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
