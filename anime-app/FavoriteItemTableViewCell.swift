//
//  FavoriteItemTableViewCell.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-17.
//

import UIKit

class FavoriteItemTableViewCell: UITableViewCell {

    @IBOutlet weak var favAnimeTitle: UILabel!
    @IBOutlet weak var favImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavoriteItem(_ anime: FavoriteAnime) {
        favAnimeTitle.text = anime.title
        if let imageUrl = anime.poster {
            ImageDownloader.downloadImage(imagePath: imageUrl) { error, imageData in
                if let imageData = imageData {
                    self.favImageView.image = UIImage(data: imageData)
                }
            }
        }
    }

}
