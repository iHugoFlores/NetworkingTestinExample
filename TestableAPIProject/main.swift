//
//  main.swift
//  TestableAPIProject
//
//  Created by Hugo Flores Perez on 5/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

let networkManager = NetworkManager(networkHandler: NetworkEngine())

let group = DispatchGroup()

group.enter()
Album.getAlbums(networkManager: networkManager){ result in
    switch result {
    case .success(let albums):
        print("API Responded. \(albums.count) entries")
        print(albums)
    case .failure(let error):
        print("Error in API: ", error)
    }
    group.leave()
}

group.wait()

print("Done waiting")
