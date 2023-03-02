//
//  MovieModels.swift
//  MovieRoll
//
//  Created by Júlia oliveira da rocha on 02/03/23.
//

import Foundation
import UIKit


struct Movie: Decodable {
    let id: String
    let rank: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
    let imDbRating: String
    let imDbRatingCount: String
}

struct Movies:Decodable{
    var items: [Movie]
}

struct actorsList:Decodable{
    let actorList:[Actor]
}

struct TVSeries: Codable {
    let id: String
    let title: String
    let originalTitle: String?
    let fullTitle: String
    let type: String
    let year: String
    let image: String
    let releaseDate: String
    let runtimeMins: Int?
    let runtimeStr: String?
    let plot: String
    let plotLocal: String?
    let plotLocalIsRtl: Bool
    let awards: String
    let directors: String
    let directorList: [String]
    let writers: String
    let writerList: [String]
    let stars: String
    let starList: [Star]
    let actorList: [Actor]

    enum CodingKeys: String, CodingKey {
        case id, title, originalTitle, fullTitle, type, year, image, releaseDate, runtimeMins, runtimeStr, plot, plotLocal, plotLocalIsRtl, awards, directors, directorList, writers, writerList, stars, starList, actorList
    }
}

struct Star: Codable {
    let id: String
    let name: String
}

struct Actor: Codable {
    let id: String
    let image: String
    let name: String
    let asCharacter: String
}
