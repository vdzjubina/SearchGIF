//
//  GIF.swift
//  GIF Search
//
//  Created by Viktorija on 24/11/2022.
//

import Foundation

struct GifResponse: Decodable {
    var data: [Gif]
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct Gif: Identifiable, Decodable {
    var id = UUID()
    var externalId: String
    var url: String
    var gifSources: GifImages
    enum CodingKeys: String, CodingKey {
        case gifSources = "images"
        case url = "url"
        case externalId = "id"
        
    }
        // Returns download url of the originial gif
    func getGifURL() -> String{
        return gifSources.original.url
    }
}

struct GifImages: Decodable {
    var original: original
    enum CodingKeys: String, CodingKey {
        case original = "original"
    }
}
// URL to data of Gif
struct original: Decodable {
    var url: String
}
