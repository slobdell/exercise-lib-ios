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
    var viewableList: [NSDictionary] = []


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exerciseTypeFilter: UISegmentedControl!
    override func viewDidLoad() {
        exerciseTypeFilter.removeAllSegments()
        var client = ExerciseLibraryClient.sharedInstance
        var exerciseTypes = client.allData["exercise_types"] as NSArray
        
        var exerciseTypesPresent:[Int: Bool] = [Int:Bool]()
        for exerciseTypeDict in exerciseTypes{
            var exerciseTypeDict = exerciseTypeDict as NSDictionary
            var id = exerciseTypeDict["id"] as Int
            exerciseTypesPresent[id] = false
        }
        
        self.baseMuscleList = [] // SBL not sure if this is necessary
        for exercise in client.allData["exercises"] as NSArray{
            var exercise = exercise as NSDictionary
            if(exercise["muscle_group_id"] as Int == self.muscleId){
                self.baseMuscleList.append(exercise)
                for exerciseTypeId in (exercise["exercise_type_ids"] as NSArray){
                    var exerciseTypeId = exerciseTypeId as Int
                    exerciseTypesPresent[exerciseTypeId] = true
                }
            }

        }

        for exerciseTypeDict in exerciseTypes{
            var exerciseTypeDict = exerciseTypeDict as NSDictionary
            var id = exerciseTypeDict["id"] as Int
            if(exerciseTypesPresent[id]!){
                var title = exerciseTypeDict["title"] as NSString
                exerciseTypeFilter.insertSegmentWithTitle(title, atIndex: id, animated: false)
            }

        }
        
        func alphabetize(this:NSDictionary, that:NSDictionary) -> Bool {
            var s1 = this["name"] as NSString
            var s2 = that["name"] as NSString
            return s1.localizedCaseInsensitiveCompare(s2) == NSComparisonResult.OrderedAscending
            
        }
        self.baseMuscleList.sort(alphabetize)

        
        super.viewDidLoad()
        exerciseTypeFilter.selectedSegmentIndex = 0
        self.filterByExerciseType()
    }
    
    func filterByExerciseType(){
        var exerciseTypeTitle = exerciseTypeFilter.titleForSegmentAtIndex(exerciseTypeFilter.selectedSegmentIndex)
        var client = ExerciseLibraryClient.sharedInstance
        var exerciseTypes = client.allData["exercise_types"] as NSArray
        var exerciseTypeId: Int = 0
        for exerciseTypeDict in exerciseTypes{
            var exerciseTypeDict = exerciseTypeDict as NSDictionary
            if((exerciseTypeDict["title"] as NSString) == exerciseTypeTitle){
                exerciseTypeId = exerciseTypeDict["id"] as Int
                break
            }
        }
        var filteredList:[NSDictionary] = []
        for exerciseDict in self.baseMuscleList{
            if(contains((exerciseDict["exercise_type_ids"] as [Int]), exerciseTypeId)){
                filteredList.append(exerciseDict)
            }
        }
        self.viewableList = filteredList
        println(self.viewableList.count)
        self.tableView.reloadData()
    }
    
    @IBAction func exerciseTypeChanged(sender: UISegmentedControl) {
        self.filterByExerciseType()
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.viewableList.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exerciseTableViewCell", forIndexPath: indexPath) as ExerciseTableViewCell
        cell.configure(self.viewableList[indexPath.row])
        return cell
    }
    



}

