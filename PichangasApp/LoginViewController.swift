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
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil){
            // Login correcto, deberiamos ir a un nuevo ViewController
            performSegueWithIdentifier("login", sender: self)
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
