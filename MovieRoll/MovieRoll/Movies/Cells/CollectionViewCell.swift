//
//  CollectionViewCell.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 01/03/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var info: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var star5: UIImageView!
    @IBOutlet var star4: UIImageView!
    @IBOutlet var star3: UIImageView!
    @IBOutlet var star2: UIImageView!
    @IBOutlet var star1: UIImageView!
    @IBOutlet var img: UIImageView!
    
    var image = UIImage()
    var onReuse: () -> Void = {}

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.loading.startAnimating()
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      onReuse()
        self.loading.startAnimating()
        img.image = nil
        img.cancelImageLoad()
    }

}


