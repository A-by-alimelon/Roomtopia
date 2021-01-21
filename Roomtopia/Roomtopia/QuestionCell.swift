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
    
    func configureButtons(score: Int) {
        for i in 0..<answerButtons.count {
            answerButtons[i].addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            if score == i + 1 {
                answerButtons[i].isSelected = true
            }
        }
    }
    
    @objc func buttonTapped(button: UIButton) {
        answerButtons.forEach {
            $0.isSelected = false
        }
        button.isSelected = !button.isSelected
        
        let sendData = [getIndexPath()!, button.tag + 1] as [Any]
        NotificationCenter.default.post(name: .changeAnswer, object: sendData)
        
    }

    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }
    
    override func prepareForReuse() {
        answerButtons.forEach {
            $0.isSelected = false
        }
    }
    
}
