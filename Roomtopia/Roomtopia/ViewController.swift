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
        surveyTableView.sectionHeaderHeight = 450
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage(named: "로고")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
    
    }
    
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! CustomHeader
//        return view
//    }
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

