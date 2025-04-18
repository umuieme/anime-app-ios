//
//  AnimeDetailModel.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-18.
//

import Foundation

class AnimeDetailRootModel: Codable {
    var success: Bool
    var results: AnimeDetailResults?
}

class AnimeDetailResults: Codable {
    var data: AnimeData?
    var seasons: [AnimeSeason]?
}

class AnimeData: Codable {
    var adultContent: Bool
    var data_id: String
    var id: String
    var title: String
    var japanese_title: String
    var poster: String
    var showType: String
    var animeInfo: AnimeInfo?
    var recommended_data: [AnimeRecommendation]?
    var related_data: [AnimeRelated]?
}

class AnimeInfo: Codable {
    var Overview: String?
    var Japanese: String?
    var Synonyms: String?
    var Aired: String?
    var Premiered: String?
    var Duration: String?
    var Status: String?
    var MAL_Score: String?
    var Genres: [String]?
    var Studios: String?
    var Producers: [String]?
    var tvInfo: TvInfo?
    
    private enum CodingKeys: String, CodingKey {
        case Overview, Japanese, Synonyms, Aired, Premiered, Duration, Status
        case MAL_Score = "MAL Score"
        case Genres, Studios, Producers, tvInfo
    }
}

class TvInfo: Codable {
    var rating: String?
    var quality: String?
    var sub: String?
    var dub: String?
    var eps: String?
    var showType: String?
    var duration: String?
}

class AnimeRecommendation: Codable {
    var data_id: String
    var id: String
    var title: String
    var japanese_title: String
    var poster: String
    var tvInfo: TvInfo?
    var adultContent: Bool
}

class AnimeRelated: Codable {
    var data_id: String
    var id: String
    var title: String
    var japanese_title: String
    var poster: String
    var tvInfo: TvInfo?
    var adultContent: Bool
}

class AnimeSeason: Codable {
    var id: String
    var data_number: Int
    var data_id: Int
    var season: String
    var title: String
    var season_poster: String
}


