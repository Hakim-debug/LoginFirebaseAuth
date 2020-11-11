//
//  Users.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-11-06.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import Foundation
import UIKit
class Users: UIViewController{
//     Global Variabel
    var accessToken=""
    var accessID=""
    var result = [String:Any]()
    
    var userFirstName = ""
    var userLastName = ""
    var userEmail = ""
    var userPhoneNr = ""
    
    func setAccessToken(accessToken: String){
        self.accessToken = accessToken
    }
    
    func setAccessId(accessID: String){
        self.accessID = accessID
    }
    
    func getAccessToken() -> String{
        return self.accessToken
    }
    
    func getAccessId() -> String{
        return self.accessID
    }
    func getResult() -> [String:Any] {
        return self.result
    }
    
    func setUserFirstName(userFirstName: String){
        self.userFirstName = userFirstName
    }
    
    func setUserLastName(userLastName: String){
        self.userLastName = userLastName
    }
    
    func setUserEmail(userEmail: String){
        self.userEmail = userEmail
    }
    
    func setUserPhoneNr(userPhoneNr: String){
        self.userPhoneNr = userPhoneNr
    }
    
    func getUserFirstName() -> String{
        return self.userFirstName
    }
    func getUserLastName() -> String{
        return self.userLastName
    }
    
    func getUserEmail() -> String{
        return self.userEmail
    }
    
    func getUserPhoneNr() -> String{
        return self.userPhoneNr
    }
    
    
        // Creating the users and post them to users in the database
    func createUser(firstName: String,lastName: String, age: String, email: String, secretMessage: String, password:String, telephoneNumber: String, tagName:String, role: String, progressBarLogin: UIProgressView ) {

            let JSONData:[String:Any] = ["firstName" : firstName,

                                    "lastName" : lastName,

                                    "age" : age,

                                    "email" : email,

                                    "secretMessage" : secretMessage,

                                    "password" : password,

                                    "telephoneNumber" : telephoneNumber,

                                    "tagName" : tagName,

                                    "role" : role]
        
        
        
            let jsonData = try? JSONSerialization.data(withJSONObject: JSONData)

                        
            progressBarLogin.progress = 0.0
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
                                    progressBarLogin.setProgress(Float(data.count), animated:true)
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
            
                 
             
        
        
                   task.resume()
               

        }



    // Authenticate users
   
    func authentication(data: Any,progressBarLogin: UIProgressView) -> URLRequest{

    let jsonData = try? JSONSerialization.data(withJSONObject: data)

    // create post request

    let url = URL(string: "http://13.48.136.153/v1/users/auth")! //PUT Your URL

            var req = URLRequest(url: url)
            req.httpMethod = "POST"

            req.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")

            req.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // insert json data to the request

            req.httpBody = jsonData
        return  req
        }
    


    

}
