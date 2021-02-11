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
            progress.completedUnitCount = Int64(count)
            progressView.setProgress(Float(progress.fractionCompleted), animated: true)
            progressLabel.text = "\(count*10)%"
            if count == 10 {
                resultImageView.image = UIImage(named: "결과")
            }
            
        }
    }
    let progress = Progress(totalUnitCount: 10)
    let resultImageView = UIImageView(image: UIImage(named: "비활성버튼"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.delegate = self
        surveyTableView.dataSource = self
        surveyTableView.allowsSelection = false
        configureFooter()
        progress.completedUnitCount = 0
        progressLabel.text = "0%"
        NotificationCenter.default.addObserver(self, selector: #selector(changeQuestionAnswer), name: .changeAnswer, object: nil)
        print() 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage(named: "대지6")

        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        
    }
    
    @objc func changeQuestionAnswer(_ notification: Notification) {
        guard let getValue = notification.object as? [Any] else { return }
        let indexPath = getValue[0] as! IndexPath, score = getValue[1] as! Int
        
        if items[indexPath.row - 1].answer == 0 {
            count += 1
        }
        
        items[indexPath.row - 1].answer = score
    }
    
    func postData(score: [Int], vc: ResultViewController) {
        let data = ["num" : score]
        let jsonData = try? JSONSerialization.data(withJSONObject: data)
        var request = URLRequest(url: URL(string: "http://13.59.190.39:5000")!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let task = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            
            DispatchQueue.main.async { [weak self] in
                let outputString = String(data: data!, encoding: String.Encoding.utf8)
                print("결과 : \(outputString)")
                vc.imageNumber = Int(outputString!)
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
        task.resume()
    }
    
    func configureFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        
        resultImageView.isUserInteractionEnabled = true
        resultImageView.contentMode = .scaleAspectFill
        resultImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapButton)))
        
        footer.addSubview(resultImageView)
        
        surveyTableView.sectionFooterHeight = 70
        
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultImageView.topAnchor.constraint(equalTo: footer.topAnchor, constant: 24),
            resultImageView.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            resultImageView.heightAnchor.constraint(equalToConstant: 50),
            resultImageView.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        surveyTableView.tableFooterView = footer
    }
    
    @objc func tapButton() {
        if count == 10 {
            
            guard let pushVC = storyboard?.instantiateViewController(identifier: "ResultViewController") as? ResultViewController else { return }
            
            var scores = [Int]()
            items.forEach {
                scores.append(5 - $0.answer + 1)
            }
            print(scores)
            postData(score: scores, vc: pushVC)
            
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

