//
//  EquipmentTableViewCell.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 4/1/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class EquipmentTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var equipmentSwitch: UISwitch!

    @IBOutlet weak var imageThumbnail: UIImageView!
    var equipmentId:Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func switchChanged(sender: AnyObject) {
        var client = ExerciseLibraryClient.sharedInstance
        if(self.equipmentSwitch.on){
            client.addEquipmentId(self.equipmentId)
        } else {
            client.removeEquipmentId(self.equipmentId)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("filterApplied", object: nil)
    }
    
    func configure(result: NSDictionary){
        self.equipmentId = result["id"] as Int
        self.label.text = result["title"] as NSString
        self.imageThumbnail.image = nil
        self.imageThumbnail.backgroundColor = UIColor.lightGrayColor()
        imageThumbnail.layer.cornerRadius = imageThumbnail.frame.size.width / 2
        imageThumbnail.layer.masksToBounds = true
        
        let url = self.insaneHack(result["image"] as NSString)
        println(url)
        self.imageThumbnail.contentMode = UIViewContentMode.ScaleAspectFit
        if let checkedUrl = NSURL(string: url){
            downloadImage(checkedUrl)
        }
    }
    
    func insaneHack(originalUrl: NSString) -> NSString{
        //https://workout-generator-static.s3.amazonaws.com/img/weight_equipment/bench.jpg
        let newDomain = originalUrl.stringByReplacingOccurrencesOfString("exercise-library", withString: "workout-generator")
        let splitUrl = split(newDomain) {$0 == "?"}
        return splitUrl[0]
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
