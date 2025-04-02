//
//  ViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 28/03/2025.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    

    @IBOutlet weak var trending: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        trending.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
    }
    
}

