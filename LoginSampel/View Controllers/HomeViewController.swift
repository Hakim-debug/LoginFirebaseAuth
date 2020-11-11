//
//  HomeViewController.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-09-28.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit

class HomeViewController: ViewController{
    
    
var text = ""
    
    @IBOutlet weak var userNameInput: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameInput.text = getSeleted()

        // Do any additional setup after loading the view.
    }
    func getSeleted() -> String{
        return self.text
    }
    func selectedName(text:String) {
        
      self.text = text
        
    }
    

    



}
