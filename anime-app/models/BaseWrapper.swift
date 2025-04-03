//
//  BaseWrapper.swift
//  anime-app
//
//  Created by Umesh Basnet on 02/04/2025.
//

class BaseWrapper : Codable{
    
    let success: Bool;
    let results: HomeDataModel;
    
    init(success: Bool, results: HomeDataModel) {
        self.success = success
        self.results = results
    }
    
}

class HomeDataModel : Codable {
    
    let spotlights : [AnimeModel]
    let trending: [AnimeModel]
    let topAiring: [AnimeModel]
    
    init(spotlights: [AnimeModel], trending: [AnimeModel], topAiring: [AnimeModel]) {
        self.spotlights = spotlights
        self.trending = trending
        self.topAiring = topAiring
    }
}
