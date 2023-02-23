//
//  ForecastVMTests.swift
//  WeatherTests
//
//  Created by Mathi on 2023-02-23.
//

import XCTest
@testable import Weather


final class ForecastVMTests: XCTestCase {
    
    var sut: ForecastVM?

    override func setUpWithError() throws {
        sut = ForecastVM()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

}
 
