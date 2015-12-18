//
//  MealTableViewCell.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 12/12/15.
//  Copyright © 2015 Jsatch. All rights reserved.
//

import UIKit

class PichangaTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var labNombrePichanga: UILabel!
    
    @IBOutlet weak var labFechaPichanga: UILabel!

    @IBOutlet weak var iviFotoPichanga: UIImageView!
    
    @IBOutlet weak var iviConfiguracion: UIImageView!
    
    @IBOutlet weak var iviIniciar: UIImageView!
    
    var pichanga : Pichanga?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    
}
