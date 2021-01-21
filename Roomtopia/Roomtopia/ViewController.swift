//
//  ViewController.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage(named: "test")
        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
    }
    
    
}

