//
//  MenuListTableViewCell.swift
//  Bap
//
//  Created by Minsoo Kim on 2019-03-07.
//  Copyright © 2019 Minsoo Kim. All rights reserved.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitleLabel: UILabel!;
    @IBOutlet weak var activatedSwitch: UISwitch!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
