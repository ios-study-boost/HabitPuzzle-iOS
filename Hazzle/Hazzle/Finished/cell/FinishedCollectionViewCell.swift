//
//  FinishedCollectionViewCell.swift
//  Hazzle
//
//  Created by 이정인 on 2020/11/05.
//

import UIKit

class FinishedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var finishedImage: UIImageView!
    @IBOutlet weak var finishedTitle: UILabel!
    @IBOutlet weak var finishedDated: UILabel!
    static let cellIdentifier = "FinishedCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
