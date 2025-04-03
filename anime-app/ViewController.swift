//
//  ViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 28/03/2025.
//

import UIKit

class ViewController: UIViewController, HomeDataFetchDelegate {
    

    @IBOutlet weak var trending: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkManager.shared.homeDataFetchDelegate = self
        NetworkManager.shared.fetchHomePage();
        
    }

    @IBAction func onFetchPressed(_ sender: Any) {
        NetworkManager.shared.fetchHomePage();

    }
    
    func didFetchHomeData(homeData: HomeDataModel) {
        print(homeData)
    }
    
    func didFailWithError(error: String) {
        
    }
    
    
    
    
}

