//
//  TestableAPITests.swift
//  TestableAPITests
//
//  Created by Hugo Flores Perez on 5/21/20.
//  Copyright © 2020 Hugo Flores Perez. All rights reserved.
//

import XCTest
@testable import TestableAPI

class MockNetworkEngine: NetworkHandler {
    var dataResponse: Data?
    var urlResponse: URLResponse?
    var errorResponse: NetworkError?
    let mockURL = URL(string: "www.google.com")
    
    func setResponses(data: Data?, urlResponse: URLResponse?, error: NetworkError?) {
        dataResponse = data
        self.urlResponse = urlResponse
        errorResponse = error
    }
    
    func getData(url: URL, _ completion: @escaping completionHandler) {
        completion(dataResponse, urlResponse, errorResponse)
    }
    
    func loadMockJSON() {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "Albums", withExtension: "json")
        dataResponse = try! Data(contentsOf: fileUrl!)
        urlResponse = HTTPURLResponse(url: mockURL!, statusCode: 200, httpVersion: nil, headerFields: nil)
    }
}

class TestableAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidResponse() throws {
        let mock = MockNetworkEngine()
        mock.loadMockJSON()
        let networkManager = NetworkManager(networkHandler: mock)
        Album.getAlbums(networkManager: networkManager) { (result) in
            switch result {
            case .success(let albums):
                XCTAssertEqual(albums.count, 2, "Number of entries do not match")
            case .failure:
                XCTFail("The test should have returned success")
            }
        }
    }
    
    func testEmptyResponse() throws {
        let mock = MockNetworkEngine()
        let networkManager = NetworkManager(networkHandler: mock)
        Album.getAlbums(networkManager: networkManager) { (result) in
            switch result {
            case .success:
                XCTFail("The test should have returned failure")
            case .failure(let error):
                if case NetworkError.emptyResult = error {
                    XCTAssertTrue(true)
                } else {
                    XCTFail("Error was not emptyResult")
                }
            }
        }
    }
}
