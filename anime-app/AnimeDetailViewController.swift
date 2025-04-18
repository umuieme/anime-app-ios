//
//  AnimeDetailViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-07.
//

import UIKit

class AnimeDetailViewController: UIViewController, AnimeDetailFetchDelegate {
    
    

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

    @IBOutlet weak var japaneseTitleLabel: UILabel!
    
    @IBOutlet weak var synonymsLabel: UILabel!
    
    @IBOutlet weak var airedLabel: UILabel!
    
    @IBOutlet weak var premieredLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
        
    @IBOutlet weak var malScoreLabel: UILabel!
    
    var isFavorite = false
    
    var animeDetail : AnimeDetailResults?

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        containerScrollView.contentInsetAdjustmentBehavior = .never
        setData()
        // Do any additional setup after loading the view.
        NetworkManager.shared.animeDetailFetchDelegate = self
        
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
            
            NetworkManager.shared.fetchAnimeDetail(animeId: animeModel.id)
        }

    }
    
    

    override func viewDidLayoutSubviews() {
        backButton.layoutMargins.top = 100

    }
    
    func didFetchAnimeDetail(anime: AnimeDetailResults) {
        animeDetail = anime
        setupAnimeDetailView()
    }
    
    func didAnimeDetailFailWithError(error: String) {
            
    }
    
    func setupAnimeDetailView() {
        if let animeInfo = animeDetail?.data?.animeInfo {
            japaneseTitleLabel.text = animeInfo.Japanese
            synonymsLabel.text = animeInfo.Synonyms
            airedLabel.text = animeInfo.Aired
            premieredLabel.text = animeInfo.Premiered
            durationLabel.text = animeInfo.Duration
            statusLabel.text = animeInfo.Status
            genreLabel.text = animeInfo.Genres?.joined(separator: ", ")
            malScoreLabel.text = animeInfo.MAL_Score
        }
    }
    
    func updateFavoriteView(){
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
    @IBAction func onViewMorePressed(_ sender: UIButton) {
        let isShowingMore = descriptionLabel.numberOfLines == 0
        descriptionLabel.numberOfLines = isShowingMore ? 3 : 0
        sender.setTitle(isShowingMore ? "View More" : "View Less", for: .normal)
    }
}
