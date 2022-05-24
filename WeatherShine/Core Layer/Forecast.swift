//
//  Forecast.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

import Foundation

struct Mission: Decodable {
    
    let missionName: String
    let launchDate: String?
    let links: Links
    let rocket: Rocket
  
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchDate = "launch_date_utc"
        case links = "links"
        case rocket = "rocket"
    }
}

struct Links: Decodable {
    
    let patchPath: String?
    let article: String?
    let wikipedia: String?
    let images: [String]
    let reddit: String?
    let video: String?
    
    enum CodingKeys: String, CodingKey {
        case patchPath = "mission_patch_small"
        case article = "article_link"
        case wikipedia = "wikipedia"
        case reddit = "reddit_media"
        case video = "video_link"
        case images = "flickr_images"
    }
}

struct Rocket: Decodable {
    
    let rocketName: String?
    
    enum CodingKeys: String, CodingKey {
        case rocketName = "rocket_name"
    }
}

