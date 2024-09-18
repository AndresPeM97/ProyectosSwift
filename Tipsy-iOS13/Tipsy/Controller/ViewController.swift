//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var twentyTipButton: UIButton!
    @IBOutlet weak var tenTipButton: UIButton!
    @IBOutlet weak var ceroTipButton: UIButton!
    @IBOutlet weak var totalBillTxtField: UITextField!
    @IBOutlet weak var numberSplitLabel: UILabel!
    
    var currentTip: Float = 0
    var bill = Bill()
    override func viewDidLoad() {
        super.viewDidLoad()
        totalBillTxtField.keyboardType = .numbersAndPunctuation
        initializeHideKeyboard()
        // Do any additional setup after loading the view.
    }


    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        if let texto = Float(totalBillTxtField.text!) {
            bill.billAmount = texto
        }
        bill.calculateBillTotal()
        
        self.performSegue(withIdentifier: "goToResult", sender: self)

        
    }
    
    @IBAction func tipSelectButtonPressed(_ sender: UIButton) {
        
        resetButtonView()
        sender.isSelected = true
        if let buttonName = sender.titleLabel?.text {
            bill.setTipPercentage(buttonPressed: buttonName)
        }
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        print(sender.value)
        bill.peopleTotal = Int(sender.value)
        numberSplitLabel.text = String(bill.peopleTotal)
        
    }
    
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bill = bill
        }
    }
    
    func resetButtonView () {
        
        ceroTipButton.isSelected = false
        tenTipButton.isSelected = false
        twentyTipButton.isSelected = false
    }
}

