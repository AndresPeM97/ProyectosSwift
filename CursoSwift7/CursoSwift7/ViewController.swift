//
//  ViewController.swift
//  CursoSwift7
//
//  Created by Andres Perez Martinez on 15/08/24.
//

import UIKit
import AVFoundation //Audio y Video

class ViewController: UIViewController {

    var reproductor: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        
        let tecla = sender.titleLabel!.text!
        sender.layer.opacity = 0.5
        
        print("Inicia la tecla \(tecla)")
        playSound(texto: tecla)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print("Termina la tecla \(tecla)")
            sender.layer.opacity = 1
        }

    }
    
    func playSound (texto: String) {
        let url = Bundle.main.url(forResource: texto, withExtension: "wav")
        
        
        reproductor = try! AVAudioPlayer(contentsOf: url!)
        reproductor.play()
    }
}

