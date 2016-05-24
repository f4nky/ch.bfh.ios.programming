//
//  EventCell.swift
//  Testing
//
//  Created by Fanky on 22.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    
    @IBOutlet weak var lblEventType: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.separatorInset = UIEdgeInsetsZero
        self.layoutMargins = UIEdgeInsetsZero
        
        self.lblEventType.layer.borderWidth = 0.5
        self.lblEventType.layer.cornerRadius = self.lblEventType.frame.size.width / 2
        self.lblEventType.layer.borderColor = UIColor.init(red: 205/255.0, green: 203/255.0, blue: 202/255.0, alpha: 1).CGColor
    }

}
