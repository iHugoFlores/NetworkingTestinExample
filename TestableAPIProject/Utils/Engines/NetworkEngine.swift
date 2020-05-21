//
//  NetworkEngine.swift
//  TestableAPIProject
//
//  Created by Hugo Flores Perez on 5/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

class NetworkEngine: NetworkHandler {
    func getData(url: URL, _ completion: @escaping completionHandler) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
