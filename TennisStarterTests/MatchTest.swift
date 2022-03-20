

import XCTest

class MatchTest: XCTestCase {
    var match: Match!
    var mirror: Mirror!
    override func setUp() {
        super.setUp()
        match = Match()
        mirror = Mirror(reflecting: match!)
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   

    func testMaxTwoInstanceVariables(){
        XCTAssertLessThanOrEqual(mirror.children.count, 2)
    }
    func testZeroPoints(){
        XCTAssertEqual(match.player1Score(), "0", "P1 match score correct with 0 points")
        XCTAssertEqual(match.player2Score(), "0", "P2 match score correct with 0 points")
    }
    func testAddOnePointToMatch() {
        
        match.addScoreToPlayer1()
        XCTAssertEqual(match.player1Score(),"1","P1 score correct with 1 point")
        
        match.addScoreToPlayer2()
        XCTAssertEqual(match.player2Score(),"1","P2 score correct with 1 point")
    }
    func testAddTwoPoints() {
        for _ in 0..<2{
            match.addScoreToPlayer1()
        }
        XCTAssertEqual(match.player1Score(),"2","P1 score correct with 2 points")
        
        for _ in 0..<2{
            match.addScoreToPlayer2()
        }
        XCTAssertEqual(match.player2Score(),"2","P2 score correct with 2 points")
    }
    func testSimpleWinP1(){
        for _ in 0..<3{
            match.addScoreToPlayer1()
        }
        XCTAssertTrue(match.player1Won(), "P1 win after 3 consecutive set wins")
    }
    func testWinAtTwoTwo(){
        for _ in 0..<2{
            match.addScoreToPlayer1()
        }
        for _ in 0..<2{
            match.addScoreToPlayer2()
        }
        XCTAssertFalse(match.player1Won(), "P1  doesnt win after two consecutive point")
        XCTAssertFalse(match.player2Won(), "P2  doesnt win after two consecutive point")
        XCTAssertFalse(match.complete(), "Game isnt complete at this stage")
    }
    func testWinAtThreeTwo(){
        for _ in 0..<2{
            match.addScoreToPlayer1() // first get players to 2 | 2
        }
        for _ in 0..<2{
            match.addScoreToPlayer2()
        }
        match.addScoreToPlayer1()  // get player 1 to 3
        XCTAssertTrue(match.player1Won(), "P1  doesnt win after two consecutive point")
        XCTAssertFalse(match.player2Won(), "P2  doesnt win after two consecutive point")
        XCTAssertTrue(match.complete(), "Game isnt complete at this stage")
    }
}
