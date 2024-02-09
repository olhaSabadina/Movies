//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Olga Sabadina on 04.01.2024.
//

import XCTest

final class MoviesUITests: XCTestCase {
    
    func testHomeScreen() {
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = app.collectionViews
        
        let stremingStaticText = collectionViewsQuery.staticTexts["On TV"]
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: stremingStaticText, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        
        XCTAssert(stremingStaticText.exists)
        stremingStaticText.tap()
        
        let cellIdentifier = "popular_0"
        
        let cell = collectionViewsQuery.cells.matching(identifier: cellIdentifier).firstMatch
        XCTAssertTrue(cell.exists, "Cell with identifier \(cellIdentifier) not found")
        cell.tap()
        
        sleep(2)
        
        let myListsText = app.scrollViews.otherElements.staticTexts["My Lists"]
        
        XCTAssert(myListsText.exists)
        
        app.scrollViews.otherElements.containing(.staticText, identifier:"Series Cast").element.swipeUp()
        
        let cellActor = app.scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.otherElements["cellActor_1"]/*[[".cells.otherElements[\"cellActor_1\"]",".otherElements[\"cellActor_1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(cellActor.exists, "Cell with identifier not found")
        
        cellActor.tap()
        
        sleep(1)
        
       let seeMoreButton = app.scrollViews.otherElements.buttons["See More"]
        XCTAssert(seeMoreButton.exists)
        
        
        
        
        
        
        
        
        
        
        //            XCTAssert(app.navigationBars.buttons["Back"].exists)
        //
        //            let elementsQuery = app.scrollViews.otherElements
        //            elementsQuery.collectionViews.containing(.other, identifier:"Vertical scroll bar, 14 pages").children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        //
        //            let knownForStaticText = elementsQuery.staticTexts["Known For"]
        //            XCTAssert(knownForStaticText.exists)
        //
        //            app.tabBars["Tab Bar"].buttons["Search"].tap()
        //
        //            let searchVcStaticText = XCUIApplication().navigationBars.staticTexts["Search VC"]
        //            XCTAssert(searchVcStaticText.exists)
        //
        //            let tablesQuery = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Trending"]/*[[".otherElements[\"Trending\"].staticTexts[\"Trending\"]",".staticTexts[\"Trending\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        //            XCTAssert(tablesQuery.exists)
        //
        //            tablesQuery.cells.otherElements.element.tap()
        //            app.navigationBars.buttons["Search VC"].tap()
        //
        //            let tabBar = app.tabBars["Tab Bar"]
        //            tabBar.buttons["Profile"].tap()
        //            tabBar.buttons["Create"].tap()
        //            tabBar.buttons["Search"].tap()
        //            tabBar.buttons["Home"].tap()
        //
        //            XCTAssert(collectionViewsQuery.staticTexts["What's Popular"].exists)
        //            XCTAssert(collectionViewsQuery.staticTexts["Free To Watch"].exists)
        //
        //            collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["In Theatres  "]/*[[".buttons[\"In Theatres  \"].staticTexts[\"In Theatres  \"]",".staticTexts[\"In Theatres  \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //            collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["For Rent"]/*[[".buttons[\"For Rent\"].staticTexts[\"For Rent\"]",".staticTexts[\"For Rent\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //            collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["On TV"]/*[[".buttons[\"On TV\"].staticTexts[\"On TV\"]",".staticTexts[\"On TV\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //            collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Streming"]/*[[".buttons[\"Streming\"].staticTexts[\"Streming\"]",".staticTexts[\"Streming\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //
    }
}
