//
//  Tools.swift
//  codeChallenge
//
//  Created by Simeng Liu on 12/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import Foundation
import UIKit
func transfer(str:String)->Double{
    
    let nsStr = str as NSString
    return nsStr.doubleValue
}

func displayError(_ error: String) {
    print(error)
    
    
    
    let alert = UIAlertController.init(title: "Error", message: error, preferredStyle:.alert)
    
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

    
}

func netWorkRequest(){
    
    
}

func imageDownloader(){
    
    
}
