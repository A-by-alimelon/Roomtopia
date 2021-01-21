//
//  QuestionCell.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class QuestionCell: UITableViewCell {
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet var answerButtons: [UIButton]!
    
    
    func configureQuestionLabel(text: String) {
        questionLabel.numberOfLines = 0
        questionLabel.text = text
    }
    
    func configureButtons() {
        for i in 0..<answerButtons.count {
            answerButtons[i].addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonTapped(button: UIButton) {
        button.isSelected = !button.isSelected
    }

}
