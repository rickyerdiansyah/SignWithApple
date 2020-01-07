//
//  TableViewCell.swift
//  SignWithApple
//
//  Created by Ricky Erdiansyah on 02/12/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var leftLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
