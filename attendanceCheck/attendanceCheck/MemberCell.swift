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
    @IBOutlet weak var btnMemberStatus: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
