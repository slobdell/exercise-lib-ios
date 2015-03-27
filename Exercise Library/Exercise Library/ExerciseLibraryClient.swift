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
    
    init() {
        self.fetch()
    }
    
    class var sharedInstance: ExerciseLibraryClient {
        return _ExerciseLibraryClientInstance
    }

    // func fetch(callback: (a: Int) -> Void){
    func fetch() {
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            "http://www.exercise-library.com/api/exercises/",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                self.allData = responseObject as NSDictionary
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
            }
        )
    }
    
}