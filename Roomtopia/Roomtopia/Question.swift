//
//  Question.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import Foundation

class Question {
    var text: String = ""
    var answer: Answer?
    
    init(_ text: String) {
        self.text = text
    }
}


enum Answer: Int {
    case veryYes = 5, yes = 4, normal = 3, no = 2, veryNo = 1
}
