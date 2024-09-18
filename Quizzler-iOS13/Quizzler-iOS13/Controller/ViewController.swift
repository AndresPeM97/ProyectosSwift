//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var gameProgressBar: UIProgressView!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
    var timer = Timer()
    var incrementoProgressBar: Float = 0.0
    var progreso: Float = 0.0
    var quizBrain = QuizzBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateUI()
        incrementoProgressBar = Float(1.0)/Float(quizBrain.totalQuestions)
        gameProgressBar.progress = 0.0
    }
    
    
    
    @IBAction func answerPressedButton(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let correctAnswer = quizBrain.checkAnswer(userAnswer)
//        print(userAnswer!, actualAnswer)
        
        if correctAnswer {
            sender.backgroundColor = UIColor.green
            quizBrain.setProgreso(incrementoProgressBar)
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        let lastQuestionReached = quizBrain.checkQuestionsLimit(quizBrain.getQuestionNumber())
        if lastQuestionReached {
            print("Tu calificacion fue \(quizBrain.progreso * 100)")
            quizBrain.resetProgress()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText(quizBrain.getQuestionNumber())
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        gameProgressBar.progress = quizBrain.getProgreso()
        scoreLabel.text = quizBrain.getScore()
    }
}

