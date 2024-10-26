//
//  DetailsViewController.swift
//  PersonInformation
//
//  Created by Sabin Tabirca on 09/02/2024.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    // outlets
    
    
    @IBOutlet weak var yyImageView: UIImageView!
    @IBOutlet weak var elementImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var elementLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var webInfoButton: UIButton!
    @IBOutlet weak var introView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    // vars and methods
    var animalData : Animal!
    

    @IBOutlet weak var moreTextView: UITextView!
    
    
    @IBAction func infoButton(_ sender: Any) {
        moreTextView.isHidden = !moreTextView.isHidden
        
        let systemImageName = moreTextView.isHidden ? "info.circle" : "info.circle.fill"
           let buttonImage = UIImage(systemName: systemImageName)
        (sender as AnyObject).setImage(buttonImage, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = animalData.name
        elementLabel.text = animalData.element
        urlLabel.text = animalData.yy
        profileImageView.image = UIImage(named: animalData.image!)
        introView.text = animalData.trine
        yyImageView.image = UIImage(named: "yinyang.png")
        elementImageView.image = UIImage(named: "wuhang.png")
        moreTextView.isHidden = true
        self.navigationItem.title = nil
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        introView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        introView.textContainer.lineFragmentPadding = 5
        introView.layer.cornerRadius = 8
        introView.clipsToBounds = true
        webInfoButton.layer.cornerRadius = 10
        webInfoButton.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        elementLabel.layer.cornerRadius = 10
        elementLabel.clipsToBounds = true
        urlLabel.layer.cornerRadius = 10
        urlLabel.clipsToBounds = true
        moreTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        moreTextView.textContainer.lineFragmentPadding = 5
        moreTextView.layer.cornerRadius = 8
        moreTextView.clipsToBounds = true


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webSegue"{
            
            // Get the new view controller using segue.destination.
            let destination = segue.destination as! WebViewController
            
            // Pass the selected object to the new view controller.
            destination.webURL = animalData.url
        }
    }
    
    
    
}
