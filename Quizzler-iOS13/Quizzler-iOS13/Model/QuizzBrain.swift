//
//  QuizzBrain.swift
//  Quizzler-iOS13
//
//  Created by Andres Perez Martinez on 18/08/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation


struct QuizzBrain {
    let quiz = [
        Question(q: "A slug's blood is green.", a: "True"),
        Question(q: "Approximately one quarter of human bones are in the feet.", a: "True"),
        Question(q: "The total surface area of two human lungs is approximately 70 square metres.", a: "True"),
        Question(q: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", a: "True"),
        Question(q: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", a: "False"),
        Question(q: "It is illegal to pee in the Ocean in Portugal.", a: "True"),
        Question(q: "You can lead a cow down stairs but not up stairs.", a: "False"),
        Question(q: "Google was originally called 'Backrub'.", a: "True"),
        Question(q: "Buzz Aldrin's mother's maiden name was 'Moon'.", a: "True"),
        Question(q: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", a: "False"),
        Question(q: "No piece of square dry paper can be folded in half more than 7 times.", a: "False"),
        Question(q: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", a: "True"),
        Question(q: "El Sol es una estrella.", a: "True"),
        Question(q: "La capital de Francia es Berlín.", a: "False"),
        Question(q: "El agua está compuesta por dos átomos de hidrógeno y uno de oxígeno.", a: "True"),
        Question(q: "La velocidad de la luz es aproximadamente 300,000 km/s.", a: "True"),
        Question(q: "Los humanos tienen cinco sentidos principales.", a: "True"),
        Question(q: "La Gran Muralla China es visible desde la Luna a simple vista.", a: "False"),
        Question(q: "El oro es un metal precioso.", a: "True"),
        Question(q: "El Monte Everest es la montaña más alta del mundo.", a: "True"),
        Question(q: "Los pingüinos pueden volar.", a: "False"),
        Question(q: "La Luna es un planeta.", a: "False")
    ]
    var totalQuestions = 0
    var questionNumber = 0
    var progreso:Float = 0.0
    var score = 0
    
    init() {
        self.totalQuestions = quiz.count
    }
    mutating func checkAnswer(_ userAnswer: String)  -> Bool {
        if userAnswer == quiz[questionNumber].answer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func getQuestionText (_ actualQuestion: Int) -> String {
        return quiz[actualQuestion].text
    }
    
    func getProgreso() -> Float {
        return progreso
    }
    
    func checkQuestionsLimit (_ actualQuestion: Int) -> Bool {
        
        if actualQuestion == quiz.count {
            return true
        } else {
            return false
        }
    }
    
    mutating func setProgreso(_ incremento:Float) {
        progreso += incremento
    }
    
    mutating func nextQuestion() {
        questionNumber += 1
    }
    
    mutating func resetProgress() {
        progreso = 0
        questionNumber = 0
    }
    
    func getQuestionNumber() -> Int {
        return questionNumber
    }
    
    func getScore() -> String {
        return String(score)
    }
    
}
