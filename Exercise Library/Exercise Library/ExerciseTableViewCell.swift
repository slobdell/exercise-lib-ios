//
//  ExerciseTableViewCell.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/29/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePreview: UIView! // SBL this should be UIImageView
    // SBL delete above variable
    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(result: NSDictionary){
        let muscleName = result["name"] as NSString
        self.label.text = muscleName
        
        let videoId = result["video_id"] as NSString
        
        let url = "https://s3-us-west-1.amazonaws.com/workout-generator-exercises/thumbnails/1/100/small_\(videoId).jpg"
        
        self.imageThumbnail.contentMode = UIViewContentMode.ScaleAspectFit
        //let image = UIImageView(frame: CGRectMake(0, 0, 100, 100))
        //self.imageThumbnail.frame = CGRectMake(0, 0, 100, 100)
        //self.imageThumbnail.layer.cornerRadius = self.imageThumbnail.frame.size.width / 2;
        //self.imageThumbnail.clipsToBounds = true;

        imageThumbnail.layer.cornerRadius = imageThumbnail.frame.size.width / 2;
        imageThumbnail.layer.masksToBounds = true;
        //var squareLength:CGFloat = 30.0
        var squareLength:CGFloat = min(imageThumbnail.frame.size.width, imageThumbnail.frame.size.height);
        //http://stackoverflow.com/questions/26628169/cropping-image-from-uiimagepickerviewcontroller-in-selected-area
        var clippedRect: CGRect = CGRectMake((imageThumbnail.frame.size.width - squareLength) / 2, (imageThumbnail.frame.size.height - squareLength) / 2, squareLength, squareLength);
        //CGImageCreateWithImageInRect
        var imageRef:CGImageRef = CGImageCreateWithImageInRect(imageThumbnail.image?.CGImage, clippedRect);
        //imageThumbnail.image?.CGImage

        if let checkedUrl = NSURL(string: url) {
            downloadImage(checkedUrl)
        }
    }
    
    func downloadImage(url:NSURL){
        self.getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.imageThumbnail.image = UIImage(data: data!)
            }
        }
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: NSData(data: data))
        }.resume()
    }
}
