//
//  Pichanga.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 14/12/15.
//  Copyright © 2015 Jsatch. All rights reserved.
//

import Foundation

class Pichanga {
    var id : String
    var nombre : String
    var fecha : String
    var urlImagen : String?
    
    init(id : String, nombrePichanga nombre : String , fechaPichanga fecha : String, urlFotoPichanga urlImagen : String?){
        self.id = id
        self.nombre = nombre
        self.fecha = fecha
        self.urlImagen = urlImagen
    }
}
