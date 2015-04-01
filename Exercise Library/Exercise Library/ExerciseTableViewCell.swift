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
        self.imageThumbnail.image = nil
        self.imageThumbnail.backgroundColor = UIColor.lightGrayColor()
        imageThumbnail.layer.cornerRadius = imageThumbnail.frame.size.width / 2;
        imageThumbnail.layer.masksToBounds = true;
        
        var dirtyHack = result["video_id"] as? NSString
        if(dirtyHack == nil){
            //videoId is null...can't figure out how to make this work as expected
            return
        }
        let videoId:NSString = result["video_id"] as NSString


        let url = "https://s3-us-west-1.amazonaws.com/workout-generator-exercises/thumbnails/1/100/small_\(videoId).jpg"

        self.imageThumbnail.contentMode = UIViewContentMode.ScaleAspectFit

        if let checkedUrl = NSURL(string: url) {
            downloadImage(checkedUrl)
        }
    }
    
    func downloadImage(url:NSURL){
        self.getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.imageThumbnail.image = UIImage(data: data!)
                self.resizeImage()
                
            }
        }
    }
    
    func resizeImage(){
        if(imageThumbnail.image == nil){
            return
        }
        //http://stackoverflow.com/questions/26628169/cropping-image-from-uiimagepickerviewcontroller-in-selected-area
        var squareLength:CGFloat = min(imageThumbnail.image!.size.width, imageThumbnail.image!.size.height);
        
        var clippedRect: CGRect = CGRectMake(
            (imageThumbnail.image!.size.width - squareLength) / 2,
            (imageThumbnail.image!.size.height - squareLength) / 2,
            squareLength,
            squareLength);
       
        var imageRef:CGImageRef = CGImageCreateWithImageInRect(imageThumbnail.image!.CGImage, clippedRect);


        var croppedImage = UIImage(CGImage: imageRef, scale: CGFloat(2.0), orientation: imageThumbnail.image!.imageOrientation)

        imageThumbnail.image = croppedImage

        imageThumbnail.layer.cornerRadius = imageThumbnail.frame.size.width / 2;
        imageThumbnail.layer.masksToBounds = true;

    }

    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: NSData(data: data))
        }.resume()
    }
}
