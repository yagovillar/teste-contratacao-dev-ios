//
//  TableViewCell.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 02/03/23.
//

import UIKit

class TableViewCellController: UITableViewCell {

    
    @IBOutlet var personagem: UILabel!
    @IBOutlet var nomeAtor: UILabel!
    @IBOutlet var imgAtor: UIImageView!
    
    var onReuse: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgAtor.layer.masksToBounds = true
        self.imgAtor.layer.cornerRadius = 28
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      onReuse()
        imgAtor.image = nil
        imgAtor.cancelImageLoad()
    }
    
}
