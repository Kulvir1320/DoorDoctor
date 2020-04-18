//
//  VideoData.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import Foundation
import UIKit

struct YTVideo: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kind: ItemKind
    let etag: String
    let id: ID
    let snippet: Snippet
}

// MARK: - ID
struct ID: Codable {
    let kind: IDKind
    let videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

enum IDKind: String, Codable {
    case youtubeVideo = "youtube#video"
}

enum ItemKind: String, Codable {
    case youtubeSearchResult = "youtube#searchResult"
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt, channelID, title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let liveBroadcastContent: LiveBroadcastContent

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, liveBroadcastContent
    }
}

enum LiveBroadcastContent: String, Codable {
    case none = "none"
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String
    let width, height: Int
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}


var images: [Data] = []
