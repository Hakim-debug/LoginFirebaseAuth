//
//  SignUpViewController.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-09-28.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var singUpButton: UIButton!
    
    
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
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextFiled)
        Utilities.styleFilledButton(singUpButton)
        
        
        
        
        

    }
//This functions Checks if the text fields data is correct.
    //Otherwise it returns the error massage
    func validateTextFields() -> String?{
        
        // Check if the text fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in the text fileds."
            
        }
        //Check if the password is sucure
        let cleanPassword = passwordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPassword) == false {
           //ovalid password
            return"Make sure your password is at least 8 charecters,contain a special chater and Nr"
        }
        
        
        
        return nil
    }
    
//SingUp Button and Validation for password function
    @IBAction func singUpTapped(_ sender: Any) {
        
        let error = validateTextFields()
        
        if error != nil {
         showError(_message: error!)
        }
        else {
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let passWord = passwordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Creat users in Firebase cloud
            Auth.auth().createUser(withEmail:email, password:passWord) { (result, err) in
                //Checks Errors
                if err != nil {
                    self.showError(_message: "Error Creating User")
                    
                }
                    //Add user to firebase
                else{
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["first_name":firstName,"last_name":lastName,"uid": result!.user.uid ]) { (error) in
                        if error != nil{
                            self.showError(_message: "Pleas Try Later Again,User did not Great Data!")
                        }
                    }
                      //Tranction to Home screen
                    self.transitionToHome()
                }
            }
            
        }
    }
    func showError(_message:String){
        
        errorLabel.text = _message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewcontroller) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
