//
//  ItemCell.swift
//  YourHomeStuff
//
//  Created by Tyler Jasper on 8/7/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    // iPhone System prefered font
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont

        let captionOneFont = UIFont.preferredFont(forTextStyle: UIFontTextStyleCaption1)
        serialNumberLabel.font = captionOneFont
    }
}
