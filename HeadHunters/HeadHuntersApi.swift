//
//  HeadHuntersApi.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import os

class HeadHuntersApi {
    static let baseUrlString = "https://headhuntersapp-api.herokuapp.com"
    static let albumsUrlString = "\(baseUrlString)/albums"
    static let genresUrlString = "\(albumsUrlString)/genres"
    
    static private func get<T: Decodable>(
        from urlString: String,
        parameters: [String : String],
        responseType: T.Type,
        responseHandler: @escaping ((T) -> Void),
        errorHandler: @escaping ((Error) -> Void)) {
        guard let url = URL(string: urlString) else {
            let message = "Error on URL"
            os_log("%@", message)
            return
        }
        Alamofire.request(url, parameters: parameters).validate().responseJSON(
            completionHandler: { response in
                switch response.result {
                case .success( _):
                    do {
                        let decoder = JSONDecoder()
                        if let data = response.data {
                            let dataResponse = try decoder.decode(responseType, from: data)
                            responseHandler(dataResponse)
                        }
                    } catch {
                        errorHandler(error)
                    }
                    
                case .failure(let error):
                    errorHandler(error)
                }
        })
    }
    
    static func getAlbums(responseHandler: @escaping ((AlbumsResponse) -> Void),
                          errorHandler: @escaping ((Error) -> Void), genre: String) {
        let parameters = ["genre" : genre]
        self.get(from: albumsUrlString, parameters: parameters,
                 responseType: AlbumsResponse.self,
                 responseHandler: responseHandler, errorHandler: errorHandler)
    }

    static func getGenres(responseHandler: @escaping ((GenreResponse) -> Void),
                          errorHandler: @escaping ((Error) -> Void)) {
        self.get(from: genresUrlString, parameters: ["":""],
                 responseType: GenreResponse.self,
                 responseHandler: responseHandler, errorHandler: errorHandler)
    }
}
