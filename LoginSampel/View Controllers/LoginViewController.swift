//
//  LoginViewController.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-09-28.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit
import Foundation
class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var emailTexfiled: UITextField!
    
    @IBOutlet weak var progressBarLogin: UIProgressView!
    
    @IBOutlet weak var passwordTexfiled: UITextField!
    
    private var observation: NSKeyValueObservation?
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var data = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        progressBarLogin.progress = 0
        setUpElements()
        transitionToHome()
        
    }
    
    func setUpElements(){
        
        //Hidde the error Label
        errorLabel.alpha = 0
     let utilities = Utilities()
    
        //Style the elemants
        utilities.styleTextField(textfield: emailTexfiled)
        utilities.styleTextField(textfield: passwordTexfiled)
        utilities.styleFilledButton(button: loginButton)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeVX" {
            let users = segue.destination as! HomeViewController
            let indexPath = sender as! IndexPath
            users.selectedName(text: "sdlfksdl")
            print("hello")
        }
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        
        
        
    
        

        //constructor
        let users = Users()
        //Creat version of the Text field
        let email = emailTexfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTexfiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(email.elementsEqual("") || password.elementsEqual("")){
            
            self.errorLabel.alpha = 1;
            
            self.errorLabel.text = "The text field must not be left empty "
            return
        }else{
//           Puting Jsondata to the server
        let json: [String: Any] =

        {
            [
                "email": "\(email)",
                "password": "\(password)",
                  "telephoneNumber": "",
            ]
        }()
         
//            Auth
         let req=users.authentication(data: json,progressBarLogin:progressBarLogin)
         let task = URLSession.shared.dataTask(with: req) { data, response, error in
        
            if let data = data {
                                                
                                DispatchQueue.main.async {
                                    self.errorLabel.alpha = 0
                                     self.progressBarLogin.setProgress(Float(data.count), animated:true)
                                                     
                                                  
                                                 }
                                                
                                             }
                                
                                          guard let data = data, error == nil else {
                                                   print(error?.localizedDescription ?? "No data")
                                                   return
                                             }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let httpResponse = response as? HTTPURLResponse {
                if( (httpResponse.statusCode) == 200){
                  
                                        
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                     DispatchQueue.main.async { //Co
                          self.errorLabel.alpha = 0
                        let newViewController =  storyBoard.instantiateViewController(withIdentifier: "HomeVX") as! HomeViewController
                        newViewController.selectedName(text: "\(users.getUserFirstName()) \(users.getUserLastName())")
                        self.present(newViewController, animated: true, completion: nil)
                    

                                   }
                                         
                    
                }else{
//                    Faild Loggin
                    DispatchQueue.main.async {
                        self.errorLabel.alpha = 1
                     
                        self.errorLabel.text="Your login fail. Check your inputs"
                        
                    }
                   
                }
            }
                                 
                         if let responseJSON = responseJSON as? [String: Any] {
                                          
                               //Code after Successfull POST Request

                                              
                                            if let array = responseJSON as? NSDictionary {
                                            
                                                   if let id = array["user"] as? NSDictionary {
                                                      print(id["_token"]! as Any )
                                                      users.setAccessToken(accessToken: id["_token"] as! String)
                                                      users.setAccessId(accessID:id["_id"] as! String )
                                                    users.setUserFirstName(userFirstName:id["firstName"] as! String )
                                                     users.setUserLastName(userLastName:id["lastName"] as! String )
                                                    
                                                    
                                                    print("\(users.getUserFirstName())")
                                                       
                                                   }
                                               
                                               }
                                           }
                   

                  
            

        }
            self.observation = task.progress.observe(\.fractionCompleted) { progress, _ in
                DispatchQueue.main.async { // Co
                    self.progressBarLogin.setProgress(Float( progress.fractionCompleted), animated:true)
                }
                
            }
        
        print(users.getAccessId())
        
        task.resume();
        
    
}
        }

       
        
        
        
        //Singun in the User
    
    
    func transitionToHome(){
           let LoginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewcontroller) as? LoginViewController
           view.window?.rootViewController = LoginViewController
           view.window?.makeKeyAndVisible()
       }
        
        
}


    
    


