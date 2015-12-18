//
//  FechaHoraViewController.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 15/12/15.
//  Copyright © 2015 Jsatch. All rights reserved.
//

import UIKit

class FechaHoraViewController: UIViewController {

    @IBOutlet weak var dpiFechaHora: UIDatePicker!
    
    @IBAction func seleccionarFechaHora(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
