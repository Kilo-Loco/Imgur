//
//  ImgurCell.swift
//  Showing Some Imgurs
//
//  Created by Kyle Lee on 6/11/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit

class ImgurCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
    }
    
    func configure(with imgur: Imgur) {
        titleLabel.text = imgur.title
        imgur.image { image in
            self.imageView.image = image
        }
    }
}
