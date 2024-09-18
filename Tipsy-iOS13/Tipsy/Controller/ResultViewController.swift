//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Andres Perez Martinez on 20/08/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var splitBetweenLabel: UILabel!
    
    var bill = Bill()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPerPersonLabel.text = String((bill.billTotal)/Float(bill.peopleTotal))
        splitBetweenLabel.text = "La cuenta se divide entre \(bill.peopleTotal) personas, con un \(bill.tipAmount*100)% de propina"
    }
    

    @IBAction func recalcualteButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
