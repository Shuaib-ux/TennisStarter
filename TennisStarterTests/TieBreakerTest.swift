
import XCTest

class TieBreakerTest: XCTestCase {

    var tie: tieBreaker!
    var mirror: Mirror!
    override func setUp() {
        super.setUp()
        tie = tieBreaker()
        mirror = Mirror(reflecting: tie!)
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
        XCTAssertEqual(tie.player1Score(), "0", "P1 tie breaker score correct with 0 points")
        XCTAssertEqual(tie.player2Score(), "0", "P2 tie breaker score correct with 0 points")
    }
    func testAddOnePointToTieBreakerGame() {
        
        tie.addScoreToPlayer1()
        XCTAssertEqual(tie.player1Score(),"1","P1 score correct with 1 point")
        
        tie.addScoreToPlayer2()
        XCTAssertEqual(tie.player2Score(),"1","P2 score correct with 1 point")
    }
    func testAddTwooints() {
        for _ in 0..<2{
            tie.addScoreToPlayer1()
        }
        XCTAssertEqual(tie.player1Score(),"2","P1 score correct with 2 points")
        
        for _ in 0..<2{
            tie.addScoreToPlayer2()
        }
        XCTAssertEqual(tie.player2Score(),"2","P2 score correct with 2 points")
    }
    func testSimpleWinP1(){
        for _ in 0..<7{
            tie.addScoreToPlayer1()
        }
        XCTAssertTrue(tie.player1Won(), "P1 win after 7 consecutive set wins")
    }
    func testNoWinP1AtSix(){
        for _ in 0..<6{
            tie.addScoreToPlayer1()
        }
        XCTAssertEqual(tie.player1Score(),"6","P1 score correct with 6 points")
        XCTAssertFalse(tie.player1Won(), "P1 doesnt win  6 striaght points")
    }
    func testNOWinAtFiveFive(){
        for _ in 0..<5{
            tie.addScoreToPlayer1()
        }
        for _ in 0..<5{
            tie.addScoreToPlayer2()
        }
        XCTAssertEqual(tie.player2Score(),"5","P2 score correct with 2 points")
        XCTAssertFalse(tie.player1Won(), "P1 doesnt win  5 | 5")
        XCTAssertFalse(tie.player2Won(), "P2 doesnt win  5 | 5")
        XCTAssertFalse(tie.complete())
    }
    func testWinAtSevenFive(){
        for _ in 0..<5{
            tie.addScoreToPlayer1()
        }
        for _ in 0..<5{
            tie.addScoreToPlayer2()
        }
        tie.addScoreToPlayer1()
        tie.addScoreToPlayer1()
        XCTAssertEqual(tie.player1Score(),"7","P1 score correct with 7 points")
        XCTAssertEqual(tie.player2Score(),"5","P2 score correct with 5 points")
        XCTAssertTrue(tie.player1Won(), "P1 Wins at 7 | 5")
        XCTAssertFalse(tie.player2Won(), "P1 Loses at 7 | 5")
        XCTAssertTrue(tie.complete())
    }
    func testWinAtSevenSeven(){
        for _ in 0..<6{
            tie.addScoreToPlayer1()
        }
        for _ in 0..<6{
            tie.addScoreToPlayer2()
        }
        tie.addScoreToPlayer1()
        tie.addScoreToPlayer2()
        XCTAssertEqual(tie.player1Score(),"7","P1 score correct with 7 points")
        XCTAssertEqual(tie.player2Score(),"7","P1 score correct with 7 points")
        XCTAssertFalse(tie.player1Won(), "P1 doesnt win at 7 | 7")
        XCTAssertFalse(tie.player2Won(), "P2 doesnt win at 7 | 7")
        XCTAssertFalse(tie.complete())
    }
    func testWinAtKeepIncreasing(){ // score keeps balancing but no one wins
        for _ in 0..<6{
            tie.addScoreToPlayer1()
        }
        for _ in 0..<6{
            tie.addScoreToPlayer2()
        }
        for _ in 0..<6{
            tie.addScoreToPlayer2()
            tie.addScoreToPlayer1()
        }
        XCTAssertEqual(tie.player1Score(),"12","P1 score correct with 12 points")
        XCTAssertEqual(tie.player2Score(),"12","P1 score correct with 12 points")
        XCTAssertFalse(tie.player1Won(), "P1 doesnt win ")
        XCTAssertFalse(tie.player2Won(), "P2 doesnt win ")
        XCTAssertFalse(tie.complete())
    }
    
    func testWinAtConsequtive2PointsAfterSixSix(){ // score keeps balancing but no one wins
        for _ in 0..<9{  // get both players to 9
            tie.addScoreToPlayer1()
            tie.addScoreToPlayer2()
        }
        for _ in 0..<2{
            tie.addScoreToPlayer1()  // win by two consequtive Points
        }
       
        XCTAssertEqual(tie.player1Score(),"11","P1 score correct with 11 points")
        XCTAssertEqual(tie.player2Score(),"9","P2 score correct with 9 points")
        XCTAssertTrue(tie.player1Won(), "P1  win ")
        XCTAssertFalse(tie.player2Won(), "P2 doesnt win ")
        XCTAssertTrue(tie.complete())
    }
    func testWinAtConsequtive1PointsAfterSixSix(){ // score keeps balancing but no one wins
        for _ in 0..<9{  // get both players to 9
            tie.addScoreToPlayer1()
            tie.addScoreToPlayer2()
        }
        
        tie.addScoreToPlayer1()  // win by two consequtive Points
        
       
        XCTAssertEqual(tie.player1Score(),"10","P1 score correct with 10 points")
        XCTAssertEqual(tie.player2Score(),"9","P2 score correct with 9 points")
        XCTAssertFalse(tie.player1Won(), "P1 doesnt win ")
        XCTAssertFalse(tie.player2Won(), "P2 doesnt win ")
        XCTAssertFalse(tie.complete())
    }
    func testNumberOfTieBreakerMatches(){
        for _ in 0..<9{  // get both players to 9
            tie.addScoreToPlayer1()
            tie.addScoreToPlayer2()
        }
        tie.addScoreToPlayer1()  // win by two consequtive Points
        XCTAssertEqual(tie.numberOfTieBreakerMatches(),19,"19 matches played in total")
    }
}

