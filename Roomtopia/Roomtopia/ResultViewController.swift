//
//  ResultViewController.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class ResultViewController: UIViewController {
    
    var imageNumber: Int?
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func configureImageViews() {
        var type = ""
        
        switch imageNumber {
        case 1:
            type = "플렉스문화인"
        case 2:
            type = "트렌디구독왕"
        case 3:
            type = "레트로집콕러"
        case 4:
            type = "감성적마이너"
        case 5:
            type = "재치있는활동가"
        case 6:
            type = "플렉스기록가"
        case 7:
            type = "합리적집콕러"
        case 8:
            type = "소통즐기는"
        default:
            print("nothing")
        }
        
        titleImageView.image = UIImage(named: "\(type)타이틀")
        imageImageView.image = UIImage(named: "\(type)")
        contentImageView.image = UIImage(named: "\(type)설")
        
    }
    
    

}
