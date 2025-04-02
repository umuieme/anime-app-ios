//
//  AnimeModel.swift
//  anime-app
//
//  Created by Umesh Basnet on 02/04/2025.
//

class AnimeModel : Codable {
    
    let id: String;
    let data_id: String;
    let title: String;
    let japanese_title: String;
    let poster: String;
    
    init(id: String, data_id: String, title: String, japanese_title: String, poster: String) {
        self.id = id
        self.data_id = data_id
        self.title = title
        self.japanese_title = japanese_title
        self.poster = poster
    }

}

