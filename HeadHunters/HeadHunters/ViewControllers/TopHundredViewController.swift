//
//  TopHundredViewController.swift
//  HeadHunters
//
//  Created by Diego Salas Noain on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import os

class TopHundredViewController: UIViewController {

    var albums: [Album] = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HeadHuntersApi.getAlbums(responseHandler: handleResponse, errorHandler: handleError, genre: "Rock")
        HeadHuntersApi.getGenres(responseHandler: handleResponse, errorHandler: handleError)
    }

    func handleResponse(response: AlbumsResponse) {
        guard let albums = response.albums else {
            self.albums = [Album]()
            return
        }
        self.albums = albums
    }
    
    func handleError(error: Error) {
        let message = "Error while requesting Albums: \(error.localizedDescription)"
        os_log("%@", message)
    }
}
