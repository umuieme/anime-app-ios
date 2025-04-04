//
//  ViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 28/03/2025.
//

import UIKit

class ViewController: UIViewController, HomeDataFetchDelegate {
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    var homeData : HomeDataModel?
    
    let cellScale: CGFloat = 0.8
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = CGFloat(240)
        
        let insetX = (view.bounds.size.width - cellWidth) / 2.0
        
        let layout = trendingCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        trendingCollectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
//        trendingCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        print(insetX)
        
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        NetworkManager.shared.homeDataFetchDelegate = self
        NetworkManager.shared.fetchHomePage();
        
    }

    @IBAction func onFetchPressed(_ sender: Any) {
        NetworkManager.shared.fetchHomePage();

    }
    
    func didFetchHomeData(homeData: HomeDataModel) {
        print(homeData)
        self.homeData = homeData
        trendingCollectionView.reloadData()
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
       return homeData?.spotlights.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView =  collectionView.dequeueReusableCell(withReuseIdentifier: "trendingCellView", for: indexPath) as! TrendingCollectionViewCell
        cellView.setData(model: homeData!.spotlights[indexPath.row])
        return cellView;
    }
}

extension ViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.trendingCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        print(cellWidthIncludingSpacing)
        print(roundedIndex);
        print(offset);
        print(scrollView.contentInset.left)
//        targetContentOffset.pointee = offset
        targetContentOffset.pointee = CGPoint(x: 304.5, y: scrollView.contentInset.top)
        
    }
    
}

