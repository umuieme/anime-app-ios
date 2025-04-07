//
//  TopAiringViewCell.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-07.
//

import UIKit

class TopAiringViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    
    func setData(anime: AnimeModel) {
        titleText.text = anime.title
        ImageDownloader.downloadImage(imagePath: anime.poster) { error, imageData in
            if let imageData = imageData{
                self.image.image =  UIImage(data: imageData)
            }
        }
    }
}
