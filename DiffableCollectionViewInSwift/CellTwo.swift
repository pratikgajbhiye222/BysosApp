//
//  CellTwo.swift
//  DiffableCollectionViewInSwift
//
//  Created by BYSOS 2019 on 15/02/21.
//

import Foundation
import SoftUIView
import UIKit
import GradientProgress
//import Cards

class contestCollectionCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: "contestCollectionCell", bundle: nil)
    }
    @IBOutlet weak var backGroundView: UIViewX!
    
    @IBOutlet weak var softUIButonEntryFees: SoftUIView!
    
    @IBOutlet weak var progrssView: GradientProgressBar!
    @IBOutlet weak var contestName: UILabel!
    
    @IBOutlet weak var prizePool: UILabel!
    
    @IBOutlet weak var spotLeft: UILabel!
    
    @IBOutlet weak var totalPrizePool: UILabel!
//    @IBOutlet weak var entryFeesPrize: UILabel!
    
    
    var entryfeesLabel: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backGroundView.layer.cornerRadius = 4
        progrssView.setProgress(1.0, animated: true)

        progrssView.progress = 0.8
        progrssView.layer.cornerRadius = 2
        let red = UIColor(red: 31.0/255.0, green: 191.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        progrssView.gradientColors = [red.cgColor , red.cgColor]
        progrssView.trackTintColor = .clear
        setUPEntryFeesLabel()
        setUpCardView()
    }
    func setup(_ item: DataForContest) {
//        titleLabel.text = item.title
//        subtitleLabel.text = item.subtitle
        let hi = item.contests?.first?.contest
    
        totalPrizePool.text = "₹ \(hi?.first?.prize ?? "0")"
        spotLeft.text = "\(String(hi?.first?.spotLeft ?? 0) ?? "0") spots left "
        entryfeesLabel.setTitle("\(String(hi?.first?.entryprice ?? 0) ?? "")", for: .normal)
    }

    func setUPEntryFeesLabel() {
//        subtitleView.type = .normal
        softUIButonEntryFees.type = .pushButton
        var red = UIColor(red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1.0)
        softUIButonEntryFees.mainColor = red.cgColor
        softUIButonEntryFees.cornerRadius = 20
        softUIButonEntryFees.darkShadowColor = UIColor.black.cgColor
        softUIButonEntryFees.lightShadowColor = UIColor.gray.cgColor
        softUIButonEntryFees.shadowOpacity = 0.8
        softUIButonEntryFees.shadowOffset = .init(width: 3, height: 2)
        softUIButonEntryFees.shadowRadius = 3
        
        entryfeesLabel = UIButton()
        entryfeesLabel.translatesAutoresizingMaskIntoConstraints = false
        entryfeesLabel.titleLabel?.textColor = .white
        entryfeesLabel.backgroundColor = .clear
//        entryfeesLabel.font = UIFont.boldSystemFont(ofSize: 16)

//        entryfeesLabel.titleLabel = "Ready"

        softUIButonEntryFees.setContentView(entryfeesLabel)
        entryfeesLabel.centerXAnchor.constraint(equalTo: softUIButonEntryFees.centerXAnchor).isActive = true
        entryfeesLabel.centerYAnchor.constraint(equalTo: softUIButonEntryFees.centerYAnchor).isActive = true
    }
    
    
    func setUpCardView() {
        var red = UIColor(red: 45.0/255.0, green: 45.0/255.0, blue:
                            45.0/255.0, alpha: 1.0)
      
    }
    
}
