//
//  CellThree.swift
//  DiffableCollectionViewInSwift
//
//  Created by BYSOS 2019 on 15/02/21.
//

import Foundation
import UIKit

class AvatarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var labelForTest: UILabel!
    
    static var nib: UINib {
        UINib(nibName: "AvatarCell", bundle: nil)
    }
    
//    @IBOutlet weak var imageView: RoundedImageView!
//    @IBOutlet weak var textLabel: UILabel!
    
    func setup(item: DataForContest) {
//        textLabel.text = item.title
        let hi = item.myContest
        labelForTest.text = hi?.first?.title
    }
}

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        layer.cornerRadius = bounds.width / 2
    }
    
}
