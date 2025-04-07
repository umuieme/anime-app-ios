//
//  ViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 28/03/2025.
//

import UIKit

class ViewController: UIViewController, HomeDataFetchDelegate {
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    @IBOutlet weak var topAiringCollectionView: UICollectionView!
    var homeData : HomeDataModel?
    
    @IBOutlet weak var trendingPageController: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width)
        let cellHeight = CGFloat(360)
        
        let layout = trendingCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)

        let topAiringlayout = topAiringCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        topAiringlayout.itemSize = CGSize(width: CGFloat(cellWidth*0.5), height: CGFloat(240))

        
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        
        topAiringCollectionView.delegate = self
        topAiringCollectionView.dataSource = self
        
        NetworkManager.shared.homeDataFetchDelegate = self
        NetworkManager.shared.fetchHomePage();
        
    }

    @IBAction func onFetchPressed(_ sender: Any) {
        NetworkManager.shared.fetchHomePage();

    }
    
    func didFetchHomeData(homeData: HomeDataModel) {
        print(homeData)
        self.homeData = homeData
        trendingPageController.numberOfPages = homeData.spotlights.count
        trendingCollectionView.reloadData()
        topAiringCollectionView.reloadData()
    }
    
    @IBAction func onTopAiringViewAll(_ sender: Any) {
        print("ontaopairing clicked")
    }
    func didFailWithError(error: String) {
        print(error)
    }
    
}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == trendingCollectionView){
            return homeData?.spotlights.count ?? 0
        } else {
            return homeData?.trending.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == trendingCollectionView){
            
            let cellView =  collectionView.dequeueReusableCell(withReuseIdentifier: "trendingCellView", for: indexPath) as! TrendingCollectionViewCell
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
        
        if(scrollView == trendingCollectionView){
            let layout = self.trendingCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            
            let roundedIndex = round(index)
            
            
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
            targetContentOffset.pointee = offset
            
            trendingPageController.currentPage = Int(index)
        }
        
    }
    
}

