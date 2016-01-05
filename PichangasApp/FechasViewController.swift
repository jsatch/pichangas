//
//  FechasViewController.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 5/01/16.
//  Copyright © 2016 Jsatch. All rights reserved.
//

import UIKit

class FechasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var pichanga : Pichanga?
    
    var fechas = [String]()
    var proxima : String?
    
    let cellIdentifier = "Cell"

    @IBOutlet weak var tviFechas: UITableView!{
        didSet{
            self.tviFechas.dataSource = self
            self.tviFechas.delegate = self
            cargarDatos()
        
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Fechas"
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0{
            return 1
        }else{
            return fechas.count
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Siguiente"
        }else{
            return "Pasadas"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var celda = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if celda == nil {
            celda = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        if indexPath.section == 0{
            celda!.textLabel!.text = self.proxima
        }else{
            celda!.textLabel!.text = fechas[indexPath.row]
        }
        
        return celda!
    }
    
    private func cargarDatos(){
        let ref = Firebase(url:"https://pichangas.firebaseio.com/pichangas/\(pichanga!.id)/fechas")
        
        ref.observeEventType(.Value, withBlock:{ snapshot in
            for fecha in snapshot.children{
                print("Key: \(fecha.key!!)")
                print("Fecha: \(fecha.value!!)")
            
                //self.fechas.append(fecha.key!!)
                if (fecha.value!! as! NSNumber).boolValue == true{
                    self.proxima = fecha.key!!
                }else{
                    self.fechas.append(fecha.key!! )
                }
            
            }
            self.tviFechas.reloadData()
        })
    }

    // MARK: - Navigation


}
