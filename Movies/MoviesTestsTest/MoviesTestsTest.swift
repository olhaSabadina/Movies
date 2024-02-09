//
//  MoviesTestsTest.swift
//  MoviesTestsTest
//
//  Created by Yura Sabadin on 09.02.2024.
//

//import XCTest


//final class MoviesTestsTest: XCTestCase {
//
//    func testExampleTest() throws {
//       let c = 7 + 5
//        XCTAssertEqual(c, 12)
//    }
//
//}

import Quick
import Nimble
@testable import Movies

class TableOfContentsSpec: QuickSpec {
  override class func spec() {
    
      describe("Movies") {
                  var calculator: Calculator!

                  beforeEach {
                      calculator = Calculator()
                  }

                  context("when adding two numbers") {
                      it("should return the correct sum") {
                          let result = calculator.add(2, 3)
                          expect(result).to(equal(5))
                      }
                  }
              }
      
  }
}
