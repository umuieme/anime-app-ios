//
//  TrendingCollectionViewCell.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-03.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setData( model  :AnimeModel) {
        titleLabel.text = model.title
        ImageDownloader.downloadImage(imagePath: model.poster) { error, imageData in
            if let imageData = imageData {
                self.image.image = UIImage(data: imageData)
            }
        }
    }
}
