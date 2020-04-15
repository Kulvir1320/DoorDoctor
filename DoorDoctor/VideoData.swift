//
//  VideoData.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation

struct YTVideo: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    var items: [Item]
}

struct Item: Codable {
    let kind: ItemKind
    let etag: String
    let id: ID
    let snippet: Snippet
}

struct ID: Codable {
    let kind: IDKind
    let videoID: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoID"
    }
}

enum IDKind: String, Codable {
    case youtubeVideo = "youtube#video"
}

enum ItemKind: String, Codable{
    case youtubeSreachResult = "youtube#searchResult"
}

struct Snippet: Codable {
    let publishedAt, channelID, title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let liveBroadcastContent: LiveBroadcastContent
    
    enum Codingkeys: String, CodingKey {
        case publishedAt
        case channelID = "channelID"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent
    }
}

enum LiveBroadcastContent: String, Codable {
    case none = "none"
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium , high
    }
}

struct Default: Codable {
    let url: String
    let width, height: Int
}

struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}

var images: [Data] = []
