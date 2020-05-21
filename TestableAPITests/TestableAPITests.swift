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
    
    func setResponses(data: Data?, urlResponse: URLResponse?, error: NetworkError?) {
        dataResponse = data
        self.urlResponse = urlResponse
        errorResponse = error
    }
    
    func getData(url: URL, _ completion: @escaping completionHandler) {
        completion(dataResponse, urlResponse, errorResponse)
    }
}

class TestableAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let networkManager = NetworkManager(networkHandler: MockNetworkEngine())
        networkManager.getData(url: URL(string: "https://jsonplaceholder.typicode.com/albums/1/photos")!) { (result: Result<Album, NetworkError>) in
            print("This is the result: ", result)
        }
        print("Right after")
        XCTAssertTrue(true)
    }
}
