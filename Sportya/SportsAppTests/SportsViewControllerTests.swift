//
//  SportsViewControllerTests.swift
//  SportyaTests
//
//  Created by Mahmoud Morsy on 01/04/2021.
//

import XCTest
@testable import Sportya

class SportsViewControllerTests: XCTestCase {
    
    var sportsViewController : SportsViewController!
    var sportsCollectionViewCell :SportsCollectionViewCell!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
        sportsViewController = stoaryboard.instantiateViewController(identifier: "SportsViewController")
        sportsCollectionViewCell = SportsCollectionViewCell()
        sportsViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sportsViewController = nil
        sportsCollectionViewCell = nil
        try super.tearDownWithError()
    }
    
    func testSportCollectionViewOutlet() {
        XCTAssertNotNil(sportsViewController.sportsCollectionView)
    }
    func testCustomeCell() {
        XCTAssertNotNil(sportsCollectionViewCell)
    }
    
    func testCollectionViewDelegate() {
        XCTAssertNotNil(sportsViewController.sportsCollectionView.delegate)
        XCTAssertNotNil(sportsViewController.sportsCollectionView.dataSource)
    }
    
       
    

}
