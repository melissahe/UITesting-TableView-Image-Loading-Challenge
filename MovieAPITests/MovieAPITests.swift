//
//  MovieAPITests.swift
//  MovieAPITests
//
//  Created by C4Q on 4/24/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import XCTest
@testable import TestingPractice

class MovieAPITests: XCTestCase {
    
    //each test should test only one thing!!
    
    //meant to test if the api is able to grab the right data
    func testMovieAPI() {
        //XCTestExpectation is for testing asynchronous calls/network requests
        let movieResultsExpectation = XCTestExpectation(description: "movie results received")
        //start network request
        MovieAPI.manager.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                //Fail test
                XCTFail("Could not get data: \(error)")
            } else if let data = data {
                do {
                    //Network request fulfilled
                    movieResultsExpectation.fulfill()
                    let movieSearch = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    let movies = movieSearch.results
                    //Assert Test - test to compare two values, one being the actual number, the other being the expectation
                    //check count
                    XCTAssertEqual(movies.count, 10, "Number of results should be greater than 0 and less than 10")
                } catch {
                    //Fail test
                    XCTFail("Decoding error: \(error)")
                }
            }
        }
        //wait 10 seconds for results because it's async
        wait(for: [movieResultsExpectation], timeout: 10)
    }
    
    //test if movies exists
    func testMovieExists() {
        //XCTestExpectation is for testing asynchronous calls/network requests
        let movieResultsExpectation = XCTestExpectation(description: "movie results exist")
        //start network request
        MovieAPI.manager.searchMovies(keyword: "") { (error, data) in
            if let error = error {
                //Fail test
                XCTFail("Could not get data: \(error)")
            } else if let data = data {
                do {
                    //Network request fulfilled
                    movieResultsExpectation.fulfill()
                    let movieSearch = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    let movies = movieSearch.results
                    //Assert Test - test to compare two values, one being the actual number, the other being the expectation
                    //check if first result is correct
                    XCTAssertEqual(movies[0].trackName, "Blue Collar Comedy Tour: One for the Road", "Movie does not exist")
                } catch {
                    //Fail test
                    XCTFail("Decoding error: \(error)")
                }
            }
        }
        //wait 10 seconds for results because it's async
        wait(for: [movieResultsExpectation], timeout: 10)
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
