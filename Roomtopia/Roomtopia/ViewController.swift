//
//  ViewController.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var surveyTableView: UITableView!
    let items = [Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."),Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다.")]

    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.delegate = self
        surveyTableView.dataSource = self
        surveyTableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage(named: "로고")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
    
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as? QuestionCell else { return UITableViewCell() }
    
        cell.configureQuestionLabel(text: items[indexPath.row].text)
        cell.configureButtons()
        
        return cell
    }
    
    
}

