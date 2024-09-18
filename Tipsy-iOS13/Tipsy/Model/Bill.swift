//
//  Bill.swift
//  Tipsy
//
//  Created by Andres Perez Martinez on 20/08/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct Bill {
    var billTotal:Float = 0
    var tipTotal:Float = 0
    var peopleTotal:Int = 2
    
    var billAmount:Float = 0
    var tipAmount:Float = 0.1
    
    mutating func setTipPercentage(buttonPressed: String){
        switch buttonPressed {
            case "10%":
                tipAmount = 0.1
            case "20%":
                tipAmount = 0.2
            default:
                tipAmount = 0
        }
    }
    
    mutating func calculateBillTotal(){
        
       billTotal = billAmount + (billAmount*tipAmount)
    }
    
}
