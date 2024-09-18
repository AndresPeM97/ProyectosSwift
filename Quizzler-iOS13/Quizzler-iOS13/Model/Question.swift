//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Andres Perez Martinez on 18/08/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        self.text = q
        self.answer = a
    }
}
