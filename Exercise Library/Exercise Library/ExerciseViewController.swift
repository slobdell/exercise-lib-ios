//
//  ExerciseViewController.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/31/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit
import MediaPlayer

class ExerciseViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var exercise:NSDictionary = NSDictionary()
    var moviePlayer:MPMoviePlayerController!
    
    @IBOutlet weak var viewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = exercise["name"] as NSString
        // video ID
        // https://s3-us-west-1.amazonaws.com/workout-generator-exercises/smaller_mp4/small_XXXX.mp4
        // Do any additional setup after loading the view.
        var videoId = exercise["video_id"] as NSString
        var urlString:NSString = "https://s3-us-west-1.amazonaws.com/workout-generator-exercises/smaller_mp4/small_\(videoId).mp4"
        var url:NSURL? = NSURL(string: urlString)
        println(url)
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        moviePlayer.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)

        moviePlayer.repeatMode = MPMovieRepeatMode.One
        
        self.viewContainer.addSubview(moviePlayer.view)
        moviePlayer.fullscreen = true
        
        moviePlayer.controlStyle = MPMovieControlStyle.Embedded
        moviePlayer.play()

        println("FINISHED")
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
