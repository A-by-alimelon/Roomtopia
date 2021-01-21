//
//  FirstCell.swift
//  Roomtopia
//
//  Created by A on 2021/01/21.
//

import UIKit

class FirstCell: UITableViewCell {

    @IBOutlet weak var firstImageView: UIImageView!
    
    func configureImageView() {
        contentView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        firstImageView.translatesAutoresizingMaskIntoConstraints = false
        firstImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -50).isActive = true
        firstImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        firstImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        firstImageView.heightAnchor.constraint(equalToConstant: 450).isActive = true
    }
    
}
