//
//  Persona.swift
//  BMI Calculator
//
//  Created by Andres Perez Martinez on 19/08/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation

struct Persona {
    var height: Double = 1.5
    var weight: Int = 100
    
    func calculateBMI () -> Double {
        
        let BMI = Double(weight) / pow(height, 2)
        
        return Double(BMI)
    }
}

func calculateIfGoodBmi (bmi: Double) -> Bool?{
    
    if bmi < 18.5 {
        return false
    }
    else if bmi > 23.5 {
        return true
    }
    else {
        return nil
    }
    
}
