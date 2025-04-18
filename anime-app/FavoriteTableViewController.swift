//
//  FavoriteTableViewController.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-17.
//

import UIKit

class FavoriteTableViewController: UITableViewController, FavoriteListChangeDelegate {
   
    
    
    var favoriteList : [FavoriteAnime] = []

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = true
        
        FavoriteManager.shared.favoriteChnageDelegate = self
        favoriteList = FavoriteManager.shared.fetchFavoriteData()

    }
    
    func onChanged(favoriteList: [FavoriteAnime]) {
        self.favoriteList = favoriteList
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteItemCell", for: indexPath) as! FavoriteItemTableViewCell

        cell.setFavoriteItem(item: favoriteList[indexPath.row])
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoriteManager.shared.removeFavoriteAnime(anime: favoriteList[indexPath.row])
            favoriteList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let selectedRow = tableView.indexPathForSelectedRow?.row  {
             if let destinationVC = segue.destination as? AnimeDetailViewController {
                 let anime = favoriteList[selectedRow]
                 destinationVC.animeModel = AnimeModel(id: anime.id!, data_id: anime.data_id!, title: anime.title!, japanese_title: anime.japanese_title!, poster: anime.poster!, description: anime.detail!)
             }
         }
    }
    
     
}
