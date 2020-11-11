//
//  signUpController.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-11-02.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import Foundation
import UIKit

class PickerView:ViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    let singInOptions=["Register with facebook","Register with google",]
    override func viewDidLoad() {
        super.viewDidLoad()
            
       
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print(singInOptions)
        return 0
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return singInOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return singInOptions[row]
    }
}

