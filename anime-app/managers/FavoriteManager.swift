//
//  FavoriteManager.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-09.
//

import Foundation
import UIKit

class FavoriteManager {

    public static var shared = FavoriteManager()
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext


    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchFavoriteData() -> [FavoriteAnime] {
        do {
            let favoriteAnimeList = try context.fetch(
                FavoriteAnime.fetchRequest())
            return favoriteAnimeList;
            
        } catch {
            return [];
        }
    }

    func addFavoriteAnime(_ anime: AnimeModel) {
        let favoriteAnime = FavoriteAnime(context: context)
        favoriteAnime.id = anime.id
        favoriteAnime.title = anime.title
        favoriteAnime.poster = anime.poster
        favoriteAnime.data_id = anime.data_id
        favoriteAnime.detail = anime.description
        favoriteAnime.japanese_title = anime.japanese_title
        saveContext()
        fetchFavoriteData()
    }

    func removeFavoriteAnime(id: String) {
        let anime = getFavoriteAnimeById(id: id)
        if let anime = anime {
            context.delete(anime)
        }
    }

    func removeFavoriteAnime(anime: FavoriteAnime) {

        context.delete(anime)
        saveContext()

    }

    func getFavoriteAnimeById(id: String) -> FavoriteAnime? {
        let fetchRequest = FavoriteAnime.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let favoriteAnimeList: [FavoriteAnime] = try context.fetch(
                fetchRequest)
            if favoriteAnimeList.count == 0 {
                return nil
            }
            return favoriteAnimeList.first
        } catch {
            return nil
        }

    }

    func isAnimeFavorite(id: String) -> Bool {
        let anime = getFavoriteAnimeById(id: id)
        return anime != nil
    }

}
