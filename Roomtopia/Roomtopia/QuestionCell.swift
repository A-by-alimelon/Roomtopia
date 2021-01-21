//
//  QuestionCell.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class QuestionCell: UITableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    
    func configureQuestionLabel(text: String) {
        questionLabel.numberOfLines = 0
        questionLabel.text = text
    }
  
}
