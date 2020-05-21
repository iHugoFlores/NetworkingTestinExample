//
//  Album.swift
//  TestableAPIProject
//
//  Created by Hugo Flores Perez on 5/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

struct Album: Codable {
    let albumId, id: Int
    let title: String
    let url, thumbnailUrl: String

    static func getAlbums(networkManager: NetworkManager, _ completion: @escaping (Result<[Self], NetworkError>) -> Void) {
        let endpoint = "https://jsonplaceholder.typicode.com/albums/1/photos"
        guard let url = URL(string: endpoint) else { print("Invalid endpoint"); return }
        networkManager.getData(url: url) { (result: Result<[Self], NetworkError>) in
            completion(result)
        }
    }
}
