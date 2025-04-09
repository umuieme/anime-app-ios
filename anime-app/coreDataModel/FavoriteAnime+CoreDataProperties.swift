//
//  FavoriteAnime+CoreDataProperties.swift
//  anime-app
//
//  Created by Umesh Basnet on 2025-04-09.
//
//

import Foundation
import CoreData


extension FavoriteAnime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteAnime> {
        return NSFetchRequest<FavoriteAnime>(entityName: "FavoriteAnime")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var poster: String?
    @NSManaged public var detail: String?
    @NSManaged public var data_id: String?
    @NSManaged public var japanese_title: String?

}

extension FavoriteAnime : Identifiable {

}
