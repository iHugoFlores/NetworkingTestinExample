//
//  NetworkEngine.swift
//  TestableAPIProject
//
//  Created by Hugo Flores Perez on 5/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case invalidResponse(Error)
    case serverError
    case serverUnavailable
    case timeOut
    case unsupportedURL
    case emptyResult
    case offline
}


protocol NetworkHandler {
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    func getData(url: URL, _ completion: @escaping completionHandler)
}
