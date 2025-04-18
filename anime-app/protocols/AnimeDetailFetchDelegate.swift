//
//  AnimeDetailFetchDelegate.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-18.
//

protocol AnimeDetailFetchDelegate {
    func didFetchAnimeDetail(anime: AnimeDetailResults)
    func didAnimeDetailFailWithError(error: String)
}
