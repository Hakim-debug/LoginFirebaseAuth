//
//  SignUpViewController.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-09-28.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit
class SignUpViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var confirmEmailTextFiled: UITextField!
    
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNrTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var errorLabel: UILabel!

    
    @IBOutlet weak var progressBarSignUp: UIProgressView!
  
    var pickerData:[String] = [String]()
      
       
       override func viewDidLoad() {
        
           super.viewDidLoad();
            setUpElements()
           self.pickerView.delegate = self
          progressBarSignUp.progress=0;
           self.pickerView.dataSource = self
        pickerView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
           pickerData=["Normal Sign-Up","Facebook", "Google"]
        
      

       }
       
           let singInOptions=["Register with facebook","Register with google"]
         
           func numberOfComponents(in pickerView: UIPickerView) -> Int { print(pickerData)
               return 1
           }
               
           func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
                print("Jol")
               return pickerData.count
           }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           getSeletedOptions = pickerData[row]
           return pickerData[row]
       }
    

    func setUpElements(){
        
        //Hidde the error Label
        errorLabel.alpha = 0
        let utilities = Utilities()
    
        //Style the elemants
        utilities.styleTextField(textfield: firstNameTextField)
        utilities.styleTextField(textfield: lastNameTextField)
        utilities.styleTextField(textfield: emailTextField)
        utilities.styleTextField(textfield: passwordTextFiled)
        utilities.styleFilledButton(button: signUpButton)
        utilities.styleTextField(textfield: ageTextField)
        utilities.styleTextField(textfield: confirmEmailTextFiled)
        
        utilities.styleTextField(textfield: phoneNrTextFiled)
        
        
             //Style the elemants
            
             //utilities.styleFilledButton(button: signUpButton)
             //utilities.styleFilledButton(button: singUpButton)
             //utilities.styleFilledButton(button: loginButton)
          

    }
    
//This functions Checks if the text fields data is correct.
    //Otherwise it returns the error massage
    func validateTextFields() -> String?{
        
        // Check if the text fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
          || confirmEmailTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
       ||
            ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        
        || phoneNrTextFiled.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in the text fileds."
            
        }
        //Check if the password is sucure
        let cleanPassword = passwordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let utilities = Utilities()
        
        if utilities.isPasswordValid(password: cleanPassword) == false {
           //ovalid password
            return"Make sure your password is at least 8 charecters,contain a special chater and Nr"
        }
        
        
        
        return nil
    }
    
    var getSeletedOptions="";
    
//SingUp Button and Validation for password function
    @IBAction func singUpTapped(_ sender: Any) {
    
        let users = Users();
        let error = validateTextFields()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController =  storyBoard.instantiateViewController(withIdentifier: "loginView") as! LoginViewController
                self.present(newViewController, animated: true, completion: nil)
        
        if error != nil {
         showError(_message: error!)
        }
        else {
            
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let passWord = passwordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let secretMessage  = passwordTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let telephoneNumber  = phoneNrTextFiled.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let age = ageTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    
            if(getSeletedOptions.elementsEqual("Google")){
            print("Google")
                       
                   }else      if(getSeletedOptions.elementsEqual("Facebook")){
             print("Facebook")
                              
          }else if(getSeletedOptions.elementsEqual("Normal Sign-Up")){
                users.createUser(firstName: firstName, lastName: lastName, age: age, email: email, secretMessage: secretMessage, password: passWord, telephoneNumber: telephoneNumber, tagName:"" , role: "",progressBarLogin: self.progressBarSignUp)
                              
            }

     

            
        }
    }
     private var observation: NSKeyValueObservation?

    func router(identifier:String, view: UIViewController){
   
        var controller = storyboard?.instantiateViewController(withIdentifier:identifier);
         controller = view
        present(controller!, animated: true, completion: nil)
    }
    
    
    // to be deleted
    func createUser(data:Any) {
        let jsonData = try? JSONSerialization.data(withJSONObject: data)
                    
        self.progressBarSignUp.progress = 0.0
        // create post request
                      let url = URL(string: "http://13.48.136.153/v1/users")! //PUT Your URL
                      var req = URLRequest(url: url)
                      req.httpMethod = "POST"
                      req.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
                      req.setValue("application/json", forHTTPHeaderField: "Content-Type")
                      // insert json data to the request
                      req.httpBody = jsonData
                    
                      let task = URLSession.shared.dataTask(with: req) { data, response, error in
                        if let data = data {
                            DispatchQueue.main.async {
                                self.progressBarSignUp.setProgress(Float(data.count), animated:true)
                            }
                        }
                    
                     guard let data = data, error == nil else {
                              print(error?.localizedDescription ?? "No data")
                              return
                        }
                
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                          if let responseJSON = responseJSON as? [String: Any] {
                              DispatchQueue.main.async {
                                
                            
                               
                            }
                        
                             
                              print(responseJSON) //Code after Successfull POST Request
                          }
                      }
        
             
              observation = task.progress.observe(\.fractionCompleted) { progress, _ in
                DispatchQueue.main.async { // Co
               self.progressBarSignUp.setProgress(Float( progress.fractionCompleted), animated:true)
                   
                }
//                 self.progressBarSignUp.setProgress(20.1, animated:true)
                //progressing!.progress(Float(progress.fractionCompleted),
                 }
               task.resume()
           
     
    }
    func showError(_message:String){
        errorLabel.text = _message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let LoginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewcontroller) as? LoginViewController
        view.window?.rootViewController = LoginViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
    
}
