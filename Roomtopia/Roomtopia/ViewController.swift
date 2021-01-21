//
//  ViewController.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var surveyTableView: UITableView!
    let items = [Question("방에 사람들이 첫번째 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."),Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다."), Question("방에 사람들이 가득찬 경우, 방의 중앙보다는 벽 가까이에 자리합니다.")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        surveyTableView.delegate = self
        surveyTableView.dataSource = self
        surveyTableView.allowsSelection = false
        surveyTableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        surveyTableView.sectionFooterHeight = 50
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let footerButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        footerButton.backgroundColor = .blue
        footerButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        footer.addSubview(footerButton)
        footerButton.translatesAutoresizingMaskIntoConstraints = false
        footerButton.topAnchor.constraint(equalTo: footer.topAnchor, constant: 8).isActive = true
        footerButton.centerXAnchor.constraint(equalTo: footer.centerXAnchor).isActive = true
        footerButton.setTitle("다음", for: .normal)
        
        surveyTableView.tableFooterView = footer
    }
    
    @objc func tapButton() {
        print("다음")
        guard let pushVC = storyboard?.instantiateViewController(identifier: "ResultViewController") else { return }
        
        navigationController?.pushViewController(pushVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage(named: "로고")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
    
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
    
        cell.configureQuestionLabel(text: items[indexPath.row - 1].text)
        cell.configureButtons()
        
        return cell
    }
    
    
}

