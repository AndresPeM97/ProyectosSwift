//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Andres Perez Martinez on 19/08/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var bmiValue: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = String(format: "%0.2f", bmiValue!)
        let bmiResult = calculateIfGoodBmi(bmi: bmiValue!)
        
        if bmiResult == true {
            adviceLabel.text = "Necesitas comer menos"
        }
        else if bmiResult == false {
            adviceLabel.text = "Necesitas comer mas"
        } else {
            adviceLabel.text = "Estas bien"
        }
    }

    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
}
