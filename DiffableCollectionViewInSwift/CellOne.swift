//
//  CellOne.swift
//  DiffableCollectionViewInSwift
//
//  Created by BYSOS 2019 on 15/02/21.
//

import Foundation
import UIKit
class BannerCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: "BannerCell", bundle: nil)
    }
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
//        imageView.layer.borderWidth = 0.5
//        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func setup(_ item: DataForContest) {
//        titleLabel.text = item.title
//        subtitleLabel.text = item.subtitle
        let hi = item.banners
        
        imageView.setCustomImage(hi?.first?.image ?? "" )
    }

}

extension UIImageView {

    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "containers")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "containers")
            }
        }
    }
}
