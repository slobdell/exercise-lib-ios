//
//  Muscle2TableViewCell.swift
//  Exercise Library
//
//  Created by Scott Lobdell on 3/28/15.
//  Copyright (c) 2015 Scott Lobdell. All rights reserved.
//

import UIKit

class Muscle2TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(result: NSArray){
        let muscleName = result[0] as NSString
        self.label.text = muscleName
    }
    

}
