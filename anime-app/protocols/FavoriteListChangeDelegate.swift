//
//  FavoriteListChange.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-18.
//

protocol FavoriteListChangeDelegate {
    func onChanged(favoriteList: [FavoriteAnime])
}
