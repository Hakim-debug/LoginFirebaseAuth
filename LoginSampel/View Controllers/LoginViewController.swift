//
//  LoginViewController.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-09-28.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTexfiled: UITextField!
    

    @IBOutlet weak var passwordTexfiled: UITextField!
    
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    func setUpElements(){
        
        //Hidde the error Label
        errorLabel.alpha = 0
        
        //Style the elemants
        Utilities.styleTextField(emailTexfiled)
        Utilities.styleTextField(passwordTexfiled)
        Utilities.styleFilledButton(loginButton)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginTapped(_ sender: Any) {
        
        //Creat version of the Text field
        
        let email = emailTexfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTexfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Singun in the User
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
        }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewcontroller) as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
}
