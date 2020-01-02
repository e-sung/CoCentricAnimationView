//
//  CoCentricCircleAnimationView_ExampleUITests.swift
//  CoCentricCircleAnimationView_ExampleUITests
//
//  Created by 류성두 on 2020/01/02.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest

class CoCentricCircleAnimationView_ExampleUITests: XCTestCase {

    func testPublicMethods() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let startButton = app.buttons["start"]
        XCTAssert(startButton.waitForExistence(timeout: 1))
        let stopButton = app.buttons["stop"]
        XCTAssert(stopButton.waitForExistence(timeout: 1))
        
        startButton.tap()
        
        sleep(3)
        
        stopButton.tap()
        sleep(1)
    }
}
