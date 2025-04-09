//
//  AnimeDetailViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-07.
//

import UIKit

class AnimeDetailViewController: UIViewController {

    var animeModel: AnimeModel?
    let favoriteManager = FavoriteManager.shared

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var containerScrollView: UIScrollView!

    @IBOutlet weak var bannerImageView: UIImageView!

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var genreLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var viewMoreDescriptionButton: UIButton!

    var isFavorite = false

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        containerScrollView.contentInsetAdjustmentBehavior = .never
        print(animeModel)
        setData()
        // Do any additional setup after loading the view.
    }

    func setData() {
        if let animeModel = animeModel {
            titleLable.text = animeModel.title
            genreLabel.text = ""
            descriptionLabel.text = animeModel.description

            ImageDownloader.downloadImage(imagePath: animeModel.poster) {
                error, imageData in
                if let imageData = imageData {
                    self.bannerImageView.image = UIImage(data: imageData)
                }
            }
            
            isFavorite = favoriteManager.isAnimeFavorite(id: animeModel.id)
            updateFavoriteView()
        }

    }

    override func viewDidLayoutSubviews() {
        backButton.layoutMargins.top = 100

    }
    
    func updateFavoriteView(){
//        bookmarkButton.imageView!.image = isFavorite ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
        bookmarkButton.setImage(isFavorite ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark"), for: .normal)
    }

    @IBAction func onBackButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onFavoriteClicked(_ sender: Any) {
        if let animeModel = animeModel {
            if(isFavorite) {
                favoriteManager.removeFavoriteAnime(id: animeModel.id)
            } else {
                favoriteManager.addFavoriteAnime(animeModel)

            }
            isFavorite = favoriteManager.isAnimeFavorite(id: animeModel.id);
            updateFavoriteView()
        }
    }
}
