//
//  ImageProductCell.swift
//  BusinessManagement
//
//  Created by Yasuda Keisuke on 3/22/15.
//  Copyright (c) 2015 Yasuda Keisuke. All rights reserved.
//

import UIKit

class ImageProductCell: PlainProductCell {

    @IBOutlet weak var prodImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
