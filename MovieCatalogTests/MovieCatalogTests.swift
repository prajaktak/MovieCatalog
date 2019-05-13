//
//  MovieCatalogTests.swift
//  MovieCatalogTests
//
//  Created by Prajakta Kulkarni on 07/05/2019.
//  Copyright © 2019 Prajakta Kulkarni. All rights reserved.
//

import XCTest
@testable import MovieCatalog

class MovieCatalogTests: XCTestCase {

    var vc:ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        vc = ViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGetMovies() {
        //given
        //when
        vc.getMovies()
        //then
        XCTAssertNotNil(vc.moviesArray)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
