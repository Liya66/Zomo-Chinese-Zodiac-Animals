//
//  CustomAnimalCell.swift
//  PersonInformation
//
//  Created by Liya Wang on 2024/3/7.
//

import UIKit
import Foundation

class CustomAnimalCell: UITableViewCell {
    
    // Create UI elements
    let customImageView = UIImageView()
    let customTextLabel = UILabel()
    let customDetailTextLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewsAndConstraints()
    }
    
    private func setupViewsAndConstraints() {
        // Add subviews
        contentView.addSubview(customImageView)
        contentView.addSubview(customTextLabel)
        contentView.addSubview(customDetailTextLabel)
        
        // Layout constraints
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customTextLabel.translatesAutoresizingMaskIntoConstraints = false
        customDetailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            customImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 280),
            customImageView.heightAnchor.constraint(equalToConstant: 280),
            
            customTextLabel.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 8),
            customTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 65),
            customTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            customDetailTextLabel.topAnchor.constraint(equalTo: customTextLabel.bottomAnchor, constant: 4),
            customDetailTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 65),
            customDetailTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            customDetailTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        customImageView.layer.cornerRadius = 20 //add radius
        customImageView.clipsToBounds = true
           
    }
    @IBOutlet weak var clippingView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
