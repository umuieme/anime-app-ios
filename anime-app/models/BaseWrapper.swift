//
//  BaseWrapper.swift
//  anime-app
//
//  Created by Umesh Basnet on 02/04/2025.
//

class BaseWrapper : Codable{
    
    let success: Bool;
    let results: HomeAnimeRespnseModel;
    
    init(success: Bool, results: HomeAnimeRespnseModel) {
        self.success = success
        self.results = results
    }
    
}

class HomeAnimeRespnseModel : Codable {
    
    let spotlights : [AnimeModel]
    let trendings: [AnimeModel]
    let topAiring: [AnimeModel]
    
    init(spotlights: [AnimeModel], trendings: [AnimeModel], topAiring: [AnimeModel]) {
        self.spotlights = spotlights
        self.trendings = trendings
        self.topAiring = topAiring
    }
}
