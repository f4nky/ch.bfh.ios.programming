//
//  MemberCell.swift
//  attendanceCheck
//
//  Created by Fanky on 17.05.16.
//  Copyright © 2016 Fanky. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {

    @IBOutlet weak var imgMemberPhoto: UIImageView!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblBirthDate: UILabel!
    
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
        //self.selectionStyle = .None
        
        self.imgMemberPhoto.clipsToBounds = true
        self.imgMemberPhoto.layer.masksToBounds = true
        self.imgMemberPhoto.layer.cornerRadius = self.imgMemberPhoto.frame.size.height / 2
        self.imgMemberPhoto.layer.borderWidth = 2
        self.imgMemberPhoto.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
