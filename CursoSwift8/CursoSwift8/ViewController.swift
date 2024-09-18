//
//  ViewController.swift
//  CursoSwift8
//
//  Created by Andres Perez Martinez on 18/08/24.
//

import UIKit

let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]

class ViewController: UIViewController {
    
    @IBOutlet weak var eggProgressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var tiempoRestante = 0.0
    var timer = Timer()
    var progreso:Float = 0.0
    
    @IBAction func EggButtonPress(_ sender: UIButton) {
        
        eggProgressBar.progress = 0.0
        let hardness = sender.titleLabel!.text!
        
        tiempoRestante = Double(eggTimes[hardness]!) * 60
        progreso = Float(1.0/tiempoRestante)
        
        timer.invalidate()
        
        print("El tiempo que tardara en estar \(hardness) es: \(eggTimes[hardness]!) minutos")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(actualizarTimer), userInfo: nil, repeats: true)
        
            
        
    }
    
    @objc func actualizarTimer() {
        
        tiempoRestante -= 1
        
        eggProgressBar.progress += progreso
        print(eggProgressBar.progress*100)
                
        if tiempoRestante == 0 {
            timer.invalidate()
            titleLabel.text = "TERMINADO!!"
        }
        

    }
    
}

