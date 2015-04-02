//
//  ExerciseLibraryClient.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/27/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import Foundation

private let _ExerciseLibraryClientInstance = ExerciseLibraryClient()

class ExerciseLibraryClient {
    
    var accessToken: String!
    var accessSecret: String!
    var allData: NSDictionary = NSDictionary()
    var initialized: Bool = false
    var availableEquipmentIds:[Int] = []
    
    init() {
        self.initialized = false
    }
    
    class var sharedInstance: ExerciseLibraryClient {
        return _ExerciseLibraryClientInstance
    }

    func configureEquipmentIds(equipmentList:NSArray){

        for equipmentDict in equipmentList{
            self.availableEquipmentIds.append(equipmentDict["id"] as Int)
        }
    }
    func filteredExercises() -> [NSDictionary]{
        var filteredList:[NSDictionary] = []
        for exerciseDict in (self.allData["exercises"] as [NSDictionary]){
            var useExercise:Bool = true
            for requiredEquipmentId in (exerciseDict["equipment_ids"] as [Int]){
                if(find(self.availableEquipmentIds, requiredEquipmentId) == nil){
                    useExercise = false
                }
            }
            if(useExercise){
                filteredList.append(exerciseDict)
            }
            
        }
        return filteredList
    }
    
    func addEquipmentId(equipmentId:Int){

        if (find(self.availableEquipmentIds, equipmentId) != nil){
            println("shouldnt actually be reached")
            return
        }
        self.availableEquipmentIds.append(equipmentId)
    }
    func removeEquipmentId(equipmentId:Int){
        var removeIndex:Int = -1
        for index in 0...self.availableEquipmentIds.count {
            let currentId:Int = self.availableEquipmentIds[index]
            if(currentId == equipmentId){
                removeIndex = index
                break
            }
        }
        if(removeIndex != -1){
            self.availableEquipmentIds.removeAtIndex(removeIndex)
        }
        
    }
    // func fetch(callback: (a: Int) -> Void){
    func fetch(callback: () -> Void, errback: () -> Void) {
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            "http://www.exercise-library.com/api/exercises/",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                self.allData = responseObject as NSDictionary
                self.configureEquipmentIds(responseObject["equipment"] as NSArray)
                self.initialized = true
                callback()
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
                errback()
            }
        )
    }
}
