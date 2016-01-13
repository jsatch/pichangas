//
//  LoginViewController.swift
//  PichangasApp
//
//  Created by Hernan Quintana on 11/12/15.
//  Copyright © 2015 Jsatch. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!{
        didSet{
            fbLoginButton.delegate = self
            fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func loginCorrecto(){
        performSegueWithIdentifier("login", sender: self)
    }
    
    func obtenerPichanguero(fbid : String){
        let ref = Firebase(url:"https://pichangas.firebaseio.com/pichangueros")
        ref.childByAppendingPath("/\(fbid)").observeSingleEventOfType(.Value, withBlock: {
            snapshot in
            
            print("Pichanguero key:  \(snapshot.key)")
            print("Pichanguero value:  \(snapshot.value["nombre"] as! String)")
            let pichanguero = Pichanguero(
                id: snapshot.key,
                facebookId: snapshot.value["fbid"] as! String,
                nombrePichanguero: snapshot.value["nombre"] as! String,
                urlFoto: snapshot.value["foto"] as! String)
            // Guardamos los datos globales del pichanguero
            GlobalVars.sharedInstance.pichanguero = pichanguero
            self.loginCorrecto()
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil){
            // Login correcto, deberiamos ir a un nuevo ViewController
            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "id, email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil{
                    print("RESULTADO: \(result["id"] as! String)")
                    self.obtenerPichanguero(result["id"] as! String)
                    
                }
            })
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        if let errorObtenido = error{
            print("Error del login \(errorObtenido.description)")
        }else if result.isCancelled{
            print("Peticion cancelada")
        }else{
            if !result.grantedPermissions.contains("user_friends"){
                print("Debe permitir contactos.")
            }
        }
        
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        print("El usuario se ha deslogueado")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
