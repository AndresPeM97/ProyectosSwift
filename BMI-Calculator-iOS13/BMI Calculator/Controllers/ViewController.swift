//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightSlider: UISlider!
    
    var persona = Persona()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        
        persona.height = Double(sender.value / 100.0)
        heightLabel.text = String(format: "%.2fm", persona.height)
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        
        persona.weight = Int(sender.value)
        weightLabel.text = String("\(persona.weight)Kg")
        
    }
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = persona.calculateBMI()
        }
    }
    
}

