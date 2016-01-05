//
//  PichanguerosCollectionViewController.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 3/01/16.
//  Copyright © 2016 Jsatch. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "PichanguerosCell"

class PichanguerosCollectionViewController: UICollectionViewController{
    var pichanga : Pichanga?
    
    var pichangueros = [Pichanguero]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.title = "Participantes"
        cargarData()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pichangueros.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PichanguerosCollectionViewCell
    
        // Configure the cell
        celda.labNombrePichanguero.text = pichangueros[indexPath.row].nombre
        
        let url = pichangueros[indexPath.row].urlFoto
        
        fetchImage(url, iviFotoPichanguero: celda.iviPichanguero)
    
        return celda
    }
    
    private func fetchImage(urlPhoto : String?, iviFotoPichanguero : UIImageView){
        if let url = urlPhoto{
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos, 0), {() -> Void in
                if let urlPho = NSURL(string: url){
                    let imageData = NSData(contentsOfURL: urlPho)
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        iviFotoPichanguero.image = UIImage(data: imageData!)
                    })
                }
            })
        }
        
    }
    
    private func cargarData(){
        // Obtenemos el listado de pichangueros
        let ref = Firebase(url:"https://pichangas.firebaseio.com/")
        ref.childByAppendingPath("pichangas/\(self.pichanga!.id)/pichangueros").observeEventType(.ChildAdded, withBlock:
            {
                snapshot in
                let pichangueroKey = snapshot.key
                
                ref.childByAppendingPath("pichangueros/\(pichangueroKey)").observeSingleEventOfType(.Value,
                    withBlock:
                    {
                        snapshot in

                        let pichanguero = Pichanguero(
                            id: snapshot.key,
                            facebookId: snapshot.value["fbid"]!! as! String,
                            nombrePichanguero: snapshot.value["nombre"]!! as! String,
                            urlFoto: snapshot.value["foto"]!! as! String
                        )
                        
                        self.pichangueros.append(pichanguero)
                        self.collectionView?.reloadData()
                        
                    })
                
            })
        
       
        
        /*let ref = Firebase(url:"https://pichangas.firebaseio.com/pichangueros")
        ref.observeEventType(.Value, withBlock: { snapshot in

            for pic in snapshot.children{

                self.pichangueros.append(
                    Pichanguero(
                        id: pic.key!!,
                        facebookId: pic.value!!["fbid"]!! as! String,
                        nombrePichanguero: pic.value!!["nombre"]!! as! String,
                        urlFoto : pic.value!!["foto"]!! as! String
                    )
                )
            }
            self.collectionView?.reloadData()

        }, withCancelBlock: { error in
            print(error.description)
        })*/
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
