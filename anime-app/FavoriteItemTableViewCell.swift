//
//  FavoriteItemTableViewCell.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-17.
//

import UIKit

class FavoriteItemTableViewCell: UITableViewCell {

    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setFavoriteItem(item: FavoriteAnime) {
        animeTitle.text = item.title
        if let imageUrl = item.poster {
            ImageDownloader.downloadImage(imagePath: imageUrl) { error, imageData in
                if let imageData = imageData{
                    self.favImageView.image =  UIImage(data: imageData)
                }
            }
        }
    }

}
