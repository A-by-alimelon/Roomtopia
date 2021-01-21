//
//  ViewController.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var surveyTableView: UITableView!
    let items = [Question("당신은 아싸인가"), Question("여행을 온 당신은 사진을 찍어 sns에 글을 올린다. "),Question("약속이 있는 다음날 당신은 집에 있고 싶으니 쉰다."), Question("맛집을 찾아간 당신은 생각보다 비싼 가격에 놀라 저렴한 다른 곳으로 간다."), Question("나의 문화생활을 위해서 돈을 쓰는게 아깝지 않다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다.")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.delegate = self
        surveyTableView.dataSource = self
        surveyTableView.allowsSelection = false
        configureFooter()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeQuestionAnswer), name: .changeAnswer, object: nil)
    }
    
    
    @objc func changeQuestionAnswer(_ notification: Notification) {
        guard let getValue = notification.object as? [Any] else { return }
        let indexPath = getValue[0] as! IndexPath, score = getValue[1] as! Int
        
        items[indexPath.row - 1].answer = score
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage(named: "대지5")

        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        
        
    }
    
    func configureFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let resultImageView = UIImageView(image: UIImage(named: "결과"))
        resultImageView.isUserInteractionEnabled = true
        resultImageView.contentMode = .scaleAspectFill
        resultImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapButton)))
        
        footer.addSubview(resultImageView)
        
        surveyTableView.sectionFooterHeight = 50
        
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultImageView.topAnchor.constraint(equalTo: footer.topAnchor, constant: 8),
            resultImageView.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            resultImageView.heightAnchor.constraint(equalToConstant: 50),
            resultImageView.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        surveyTableView.tableFooterView = footer
    }
    
    @objc func tapButton() {
        guard let pushVC = storyboard?.instantiateViewController(identifier: "ResultViewController") else { return }
        
        navigationController?.pushViewController(pushVC, animated: true)
    }
    
    
    
}

extension ViewController: UITableViewDelegate {
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let firstCell = tableView.dequeueReusableCell(withIdentifier: "FirstCell") as? FirstCell else { return UITableViewCell() }
            firstCell.configureImageView()
            return firstCell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as? QuestionCell else { return UITableViewCell() }
        let question = items[indexPath.row - 1]
        
        cell.configureQuestionLabel(text: question.text)
        print("question.answer: \(question.answer)")
        cell.configureButtons(score: question.answer)
        
        return cell
    }
    
    
}

