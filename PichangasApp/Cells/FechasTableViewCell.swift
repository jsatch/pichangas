//
//  FechasTableViewCell.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 5/01/16.
//  Copyright © 2016 Jsatch. All rights reserved.
//

import UIKit

class FechasTableViewCell: UITableViewCell {

    @IBOutlet weak var labFecha: UILabel!
    

    @IBOutlet weak var switchAnotado: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
