//
//  PichangasViewController.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 12/12/15.
//  Copyright © 2015 Jsatch. All rights reserved.
//

import UIKit

class PichangasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    var pichangas = [Pichanga]()
    var selectedPichanga : Pichanga?

    @IBOutlet weak var tviPichangas: UITableView!{
        didSet{
            cargarPichangas()
            tviPichangas.dataSource = self
            tviPichangas.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let ref = Firebase(url:"https://pichangas.firebaseio.com/pichangas")
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            for pichanga in snapshot.children{
                self.pichangas.append(
                    Pichanga(
                        id: pichanga.key!!,
                        nombrePichanga: pichanga.value!!["nombre"]!! as! String,
                        fechaPichanga: pichanga.value!!["proxima"]!! as! String,
                        urlFotoPichanga: nil
                    )
                )
            }
            
            self.tviPichangas.reloadData()
            
        }, withCancelBlock: { error in
            print(error.description)
        })
    }
    
    func onIniciarTap(gesture : UITapGestureRecognizer){
        let location : CGPoint = gesture.locationInView(tviPichangas)
        let panIndexPath : NSIndexPath = tviPichangas.indexPathForRowAtPoint(location)!
        let viewCell : UITableViewCell = tviPichangas.cellForRowAtIndexPath(panIndexPath)!
        if let celda = viewCell as? PichangaTableViewCell{
            if let pichangaId = celda.pichanga?.id {
                print("Se eligio la pichanga con id \(pichangaId)")
                self.selectedPichanga = celda.pichanga
                performSegueWithIdentifier("show fechas", sender: self)
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
                self.selectedPichanga = celda.pichanga
                performSegueWithIdentifier("show configurar", sender: self)
            }else{
                print("error")
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
                case "show configurar":
                    if selectedPichanga != nil{
                        let pichanguerosvc = segue.destinationViewController as! PichanguerosCollectionViewController
                        pichanguerosvc.pichanga = selectedPichanga!
                    }
                
                case "show fechas":
                    if selectedPichanga != nil{
                        let fechasvc = segue.destinationViewController as! FechasViewController
                        fechasvc.pichanga = selectedPichanga!
                    }
                default:
                break
            }
        }
        
        
    }



}
