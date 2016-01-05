//
//  Pichaguero.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 3/01/16.
//  Copyright © 2016 Jsatch. All rights reserved.
//

import Foundation

class Pichanguero {
    var id : String
    var fbid : String?
    var nombre : String
    var urlFoto : String?
    
    init(id : String, facebookId fbid : String, nombrePichanguero nombre : String, urlFoto : String){
        self.id = id
        self.fbid = fbid
        self.nombre = nombre
        self.urlFoto = urlFoto
    }
}