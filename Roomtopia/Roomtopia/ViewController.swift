//
//  ViewController.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var surveyTableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    let items = [Question("한 번 사는 인생, 재밌게 살고 싶다."), Question("나는 여행을 가면 사진을 꼭 찍어 sns에 글을 올린다."),Question("나는 인싸다."), Question("나는 문화생활을 위해 쓰는 돈이 별로 아깝지 않다."), Question("나는 약속이 있는 다음 날 집에서 쉰다."), Question(" 나는 낯선 사람들과 있어도 금방 잘 어울린다."), Question("시험기간에 나는 친구들과 모여서 함께 공부한다."), Question("간짜장을 시켰는데 일반 짜장이 배달오자 배달원에게 다시 가져가 달라고 한다."), Question("맛집을 찾아간 나는 비싼 가격에 놀라 다른 가게로 간다."), Question("나는 계획이 없는 편이다.")]
    
    var count = 0 {
        didSet {
            if count == 10 {
                print("다해")
            }
            progress.completedUnitCount = Int64(count)
            progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            progressLabel.text = "\(count*10)%"
        }
    }
    let progress = Progress(totalUnitCount: 10)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.delegate = self
        surveyTableView.dataSource = self
        surveyTableView.allowsSelection = false
        configureFooter()
        progress.completedUnitCount = 0
        progressLabel.text = "0%"
        NotificationCenter.default.addObserver(self, selector: #selector(changeQuestionAnswer), name: .changeAnswer, object: nil)
    }
    
    
    @objc func changeQuestionAnswer(_ notification: Notification) {
        guard let getValue = notification.object as? [Any] else { return }
        let indexPath = getValue[0] as! IndexPath, score = getValue[1] as! Int
        
        if items[indexPath.row - 1].answer == 0 {
            count += 1
        }
        
        items[indexPath.row - 1].answer = score
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage(named: "대지나")

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
        if count == 10 {
            guard let pushVC = storyboard?.instantiateViewController(identifier: "ResultViewController") else { return }
            
            var scores = [Int]()
            items.forEach {
                scores.append(5 - $0.answer + 1)
            }
            print(scores)
            navigationController?.pushViewController(pushVC, animated: true)
        } else {
            
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
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
        cell.configureButtons(score: question.answer)
        
        return cell
    }
    
    
}

