//
//  GiphyClient.swift
//  GIF Search
//
//  Created by Viktorija on 24/11/2022.
//

import Foundation
import RxSwift
import RxCocoa


let BASE_URL = "https://api.giphy.com"
let API_KEY = "KQOrj3ZpPT1JhkaVSbV7TE0CZwC59q8F"
let LIMIT  = 20
let RATING = "g"
let LANGUAGE = "en"
let trending = "trending"
let search = "search"



class GiphyClient {
    var requestObservable: RequestObservable
    
    init(requestObservable: RequestObservable) {
        self.requestObservable = requestObservable
    }

    func getGifImages(searchTerm: String, from: Int = 0)-> Observable<GifResponse> {
        var request = getRequestUrl(searchTerm: searchTerm)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return requestObservable.callAPI(request: request)
    }
    
    private func getRequestUrl(searchTerm: String, from: Int = 0) -> URLRequest {
       let  replaced = searchTerm.replacingOccurrences(of: " ", with: "+")
        if searchTerm.caseInsensitiveCompare(trending) == .orderedSame {
            return URLRequest(url: URL(string:"\(BASE_URL)/v1/gifs/\(trending)?api_key=\(API_KEY)&limit=\(LIMIT)&rating=\(RATING)")!)
        } else {
            return URLRequest(url: URL(string:"\(BASE_URL)/v1/gifs/\(search)?api_key=\(API_KEY)&q=\(replaced)&limit=\(LIMIT)&offset=\(from)&rating=\(RATING)&lang=\(LANGUAGE)")!)
        }
    }
    
}
