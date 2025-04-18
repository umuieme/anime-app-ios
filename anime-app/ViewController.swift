//
//  TestViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 17/04/2025.
//

import UIKit

class ViewController: UIViewController, HomeDataFetchDelegate {

    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var spotLightCollectionView: UICollectionView!
    @IBOutlet weak var spotLightPageController: UIPageControl!
    @IBOutlet weak var topAiringCollectionView: UICollectionView!

    var homeData : HomeDataModel?
    var selectedAnime : AnimeModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        containerScrollView.contentInsetAdjustmentBehavior = .never
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width)
        let cellHeight = CGFloat(360)
        
        let layout = spotLightCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)

        
        
        spotLightCollectionView.delegate = self
        spotLightCollectionView.dataSource = self
        
        topAiringCollectionView.delegate = self
        topAiringCollectionView.dataSource = self
        
        NetworkManager.shared.homeDataFetchDelegate = self
        NetworkManager.shared.fetchHomePage();
    }
    

    func didFetchHomeData(homeData: HomeDataModel) {
        print(homeData)
        self.homeData = homeData
        spotLightPageController.numberOfPages = homeData.spotlights.count
        spotLightCollectionView.reloadData()
        topAiringCollectionView.reloadData()
    }
    

    func didFailWithError(error: String) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAnimeDetail", let selectedAnime = selectedAnime {
            if let destinationVC = segue.destination as? AnimeDetailViewController {
                destinationVC.animeModel = selectedAnime
            }
        }
    }
    
}


extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == spotLightCollectionView){
            return homeData?.spotlights.count ?? 0
        } else  if(collectionView == topAiringCollectionView){
            return homeData?.topAiring.count ?? 0
        }
        
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == spotLightCollectionView){
            
            let cellView =  collectionView.dequeueReusableCell(withReuseIdentifier: "spotlightCellView", for: indexPath) as! TrendingCollectionViewCell
            cellView.setData(model: homeData!.spotlights[indexPath.row])
            return cellView;
        } else if(collectionView == topAiringCollectionView){
            let cellVioew = collectionView.dequeueReusableCell(withReuseIdentifier: "topAiringCellView", for: indexPath) as! TopAiringViewCell
            cellVioew.setData(anime: homeData!.topAiring[indexPath.row])
            return cellVioew;
        }
        
        return UICollectionViewCell()
    }
    
   
}


extension ViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(scrollView == spotLightCollectionView){
            let layout = self.spotLightCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            
            let roundedIndex = round(index)
            
            
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
            targetContentOffset.pointee = offset
            
            spotLightPageController.currentPage = Int(index)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == spotLightCollectionView {
            selectedAnime = homeData?.spotlights[indexPath.row]
        } else if collectionView == topAiringCollectionView {
            selectedAnime = homeData?.topAiring[indexPath.row]
        }
        performSegue(withIdentifier: "showAnimeDetail", sender: collectionView)
    }
    
}

