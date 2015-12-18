//
//  PichangasViewController.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 12/12/15.
//  Copyright © 2015 Jsatch. All rights reserved.
//

import UIKit

class PichangasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: Propertie
    var pichangas = [Pichanga]()
    

    @IBOutlet weak var tviPichangas: UITableView!{
        didSet{
            cargarPichangas()
            tviPichangas.dataSource = self
            tviPichangas.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return pichangas.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let celda = tableView.dequeueReusableCellWithIdentifier("PichangaTableViewCell", forIndexPath: indexPath) as! PichangaTableViewCell
        
        celda.labNombrePichanga.text = pichangas[indexPath.row].nombre
        celda.labFechaPichanga.text = pichangas[indexPath.row].fecha
        celda.pichanga = pichangas[indexPath.row]
        
        let recognizerConfigurar = UITapGestureRecognizer(target: self, action: "onConfigurarTap:")
        recognizerConfigurar.delegate = self
        celda.iviConfiguracion.addGestureRecognizer(recognizerConfigurar)
        
        let recognizerIniciar = UITapGestureRecognizer(target: self, action: "onIniciarTap:")
        recognizerIniciar.delegate = self
        celda.iviIniciar.addGestureRecognizer(recognizerIniciar)
        
        return celda
    }
    
    
    func cargarPichangas(){
        pichangas.append(Pichanga(id : 1, nombrePichanga: "La pichanga del pueblo", fechaPichanga: "20/12/2015", urlFotoPichanga: nil))
        pichangas.append(Pichanga(id : 2, nombrePichanga: "La pichanga del cole", fechaPichanga: "21/12/2015", urlFotoPichanga: nil))
        pichangas.append(Pichanga(id : 3, nombrePichanga: "La pichanga de la universidad", fechaPichanga: "22/12/2015", urlFotoPichanga: nil))
        pichangas.append(Pichanga(id : 4, nombrePichanga: "La pichanga de la gente", fechaPichanga: "23/12/2015", urlFotoPichanga: nil))
    }
    
    func onIniciarTap(gesture : UITapGestureRecognizer){
        let location : CGPoint = gesture.locationInView(tviPichangas)
        let panIndexPath : NSIndexPath = tviPichangas.indexPathForRowAtPoint(location)!
        let viewCell : UITableViewCell = tviPichangas.cellForRowAtIndexPath(panIndexPath)!
        if let celda = viewCell as? PichangaTableViewCell{
            if let pichangaId = celda.pichanga?.id {
                print("Se eligio la pichanga con id \(pichangaId)")
                performSegueWithIdentifier("show iniciar", sender: self)
            }else{
                print("error")
            }
        }
        
    }
    
    func onConfigurarTap(gesture : UITapGestureRecognizer){
        let location : CGPoint = gesture.locationInView(tviPichangas)
        let panIndexPath : NSIndexPath = tviPichangas.indexPathForRowAtPoint(location)!
        let viewCell : UITableViewCell = tviPichangas.cellForRowAtIndexPath(panIndexPath)!
        if let celda = viewCell as? PichangaTableViewCell{
            if let pichangaId = celda.pichanga?.id {
                print("Configurar. Se eligio la pichanga con id \(pichangaId)")
                performSegueWithIdentifier("show configurar", sender: self)
            }else{
                print("error")
            }
        }
        
    }



}
