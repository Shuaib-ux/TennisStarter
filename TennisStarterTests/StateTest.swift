

import XCTest

class StateTest: XCTestCase {

    var state: State!
    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        state = State()
        mirror = Mirror(reflecting: state!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testupdateNewBallFunction(){
        state.updateNewballsRequest()
        XCTAssertFalse(state.shouldAskForNewBall)
        state.numberOfGamesPlayed=7
        state.updateNewballsRequest()
        XCTAssertTrue(state.shouldAskForNewBall)
        state.numberOfGamesPlayed=9
        XCTAssertTrue(state.shouldAskForNewBall)
        
    }
    func testResetStates(){
        state.game.addPointToPlayer1()
        state.game.addPointToPlayer2()
        state.resetGame()
        XCTAssertEqual(state.game.player1Score(),"0","P2 score correct with 2 points")
        XCTAssertEqual(state.game.player1Score(),"0","P2 score correct with 2 points")
        
        
    }
}
