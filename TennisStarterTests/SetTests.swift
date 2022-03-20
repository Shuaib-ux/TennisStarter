import XCTest


class SetTests: XCTestCase {
    var set_: Set_!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        set_ = Set_()
        mirror = Mirror(reflecting: set_!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMaxTwoInstanceVariables(){
        XCTAssertLessThanOrEqual(mirror.children.count, 2)
    }
    func testZeroPoints(){
        XCTAssertEqual(set_.player1Score(), "0", "P1 score correct with 0 points")
        XCTAssertEqual(set_.player2Score(), "0", "P2 score correct with 0 points")
    }
    
    func getToTieBreaker(){ // here we first get both players to 5
        for _ in 0..<6{
            set_.addScoreToPlayer1()
            set_.addScoreToPlayer2()
        }
        
    }
    func testAddOnePoint() {
        
        set_.addScoreToPlayer1()
        XCTAssertEqual(set_.player1Score(),"1","P1 score correct with 1 point")
        
        set_.addScoreToPlayer2()
        XCTAssertEqual(set_.player2Score(),"1","P2 score correct with 1 point")
    }
    func testAddFourPoints() {
        for _ in 0..<4{
            set_.addScoreToPlayer1()
        }
        XCTAssertEqual(set_.player1Score(),"4","P1 score correct with 4 points")
        
        for _ in 0..<4{
            set_.addScoreToPlayer2()
        }
        XCTAssertEqual(set_.player2Score(),"4","P2 score correct with 4 points")
    }
    
    func testSimpleWinP1(){
        for _ in 0..<6{
            set_.addScoreToPlayer1()
        }
        XCTAssertTrue(set_.player1Won(), "P1 win after 6 consecutive points")
    }
    func testIsOnNotTieBreakerFiveFive(){
        for _ in 0..<5{ // get to 5
            set_.addScoreToPlayer1()
        }
        for _ in 0..<5{
            set_.addScoreToPlayer2()
        }
        XCTAssertFalse(set_.isTieBreaker())
    }
    func testIsOnNotTieBreaker(){
        getToTieBreaker()
        XCTAssertTrue(set_.isTieBreaker())
    }
    func testReachingTieBreaker(){
        getToTieBreaker()
        XCTAssertEqual(set_.player1Score(),"6","P1 score correct reaching TieBreaker")
        XCTAssertEqual(set_.player2Score(),"6","P2 score correct reaching TieBreaker")
        XCTAssertFalse(set_.player1Won())
        XCTAssertFalse(set_.player2Won())
        XCTAssertFalse(set_.complete()) // game isnt complete at a tiebreaker
    
    }
    func testWinBySevenFiveP1(){
        for _ in 0..<5{ // get to 5
            set_.addScoreToPlayer1()
        }
        for _ in 0..<5{
            set_.addScoreToPlayer2()
        }
        // then get to 7
        set_.addScoreToPlayer1()
        set_.addScoreToPlayer1()
        XCTAssertEqual(set_.player1Score(),"7","P1  score")
        XCTAssertEqual(set_.player2Score(),"5","P2 score")
        XCTAssertTrue(set_.player1Won(),"P1 wins by 7 / 5")
        XCTAssertFalse(set_.player2Won(),"P2 looses by 2 points")
        XCTAssertTrue(set_.complete()) // game is complete at 7 | 5
    
    }
    func testGameCompeleteP1Win(){
        for _ in 0..<6{ // get to 6 which wins
            set_.addScoreToPlayer1()
        }
        XCTAssertTrue(set_.complete())
    }
    func testMethodsNoSideEffects(){
        set_.addScoreToPlayer1()
        set_.addScoreToPlayer1()
        _ = set_.complete()
        _ = set_.player1Won()
        _ = set_.player2Won()
        _ = set_.isTieBreaker()
        _ = set_.player1Score()
        set_.addScoreToPlayer1() //3 points
        XCTAssertEqual(set_.player1Score(), "3")
        set_.addScoreToPlayer1()
        set_.addScoreToPlayer1() //5
        _ = set_.complete()
        _ = set_.player1Won()
        XCTAssertFalse(set_.player1Won())
        XCTAssertFalse(set_.complete())
        set_.addScoreToPlayer1()// to six
        _ = set_.complete()
        _ = set_.player1Won()
        XCTAssertTrue(set_.player1Won())
        XCTAssertTrue(set_.complete())
    }
    
    
}
