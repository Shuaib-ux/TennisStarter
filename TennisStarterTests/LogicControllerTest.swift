// this test the entirerity of games
import XCTest

class LogicControllerTest: XCTestCase {

    var mirror: Mirror!
    
    override func setUp() {
        super.setUp()
        
       mirror = Mirror(reflecting: LogicController())
    }
    override func tearDownWithError() throws {
        LogicController.restartState()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func addPointPlayer1(){
        LogicController.addPointPlayer1()
    }
    func addPointPlayer2(){
        LogicController.addPointPlayer2()
    }
    func getToDeuceFromZero(){
        for _ in 0..<3{
            addPointPlayer1()
            addPointPlayer2()
        }
        
    }
    func straightWinGameP1(){
        for _ in 0..<4{
            addPointPlayer1()
        }
        
    }
    func straightWinGameP2(){
        for _ in 0...3{
            addPointPlayer2()
        }
    }
    func straightWinSetP1(){ // win 6  straight games to win a set
        for _ in 0..<6{
            straightWinGameP1()
        }
       
    }
    
    func straightWinSetP2(){ // win 6  straight games to win a set
        for _ in 0..<6{
            straightWinGameP2()
        }
       
    }
    func getToTieBreaker(){
        for _ in 0..<5{
            straightWinGameP1()
            straightWinGameP2()
        }
        straightWinGameP1()
        straightWinGameP2()
    }
  
    func testZeroPoints(){
       
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(), "0", "P1 score correct with 0 points")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(), "0", "P2 score correct with 0 points")
    }
    func testAddTwoPoints(){

        for _ in 0..<2{
            addPointPlayer1()
        }
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"30","P1 score correct with 2 points")
        for _ in 0..<2{
            addPointPlayer2()
        }
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"30","P2 score correct with 2 points")
        
    }
    func testReachingDeuce(){

        getToDeuceFromZero()
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"40","P1 score correct reaching Deuce")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"40","P2 score correct reaching Deuce")
        XCTAssertFalse(LogicController.state.player1.wonGame(game: LogicController.state.game))
        XCTAssertFalse(LogicController.state.player2.wonGame(game: LogicController.state.game))
        XCTAssertFalse(LogicController.state.game.complete())
    }
    func testStraightWinFunctionP1(){ // set increasses by one
       
        straightWinGameP1()
        XCTAssertEqual(LogicController.state.player1.getPlayerGamepoints(),"1","P1 set score is now 1")
        XCTAssertEqual(LogicController.state.player2.getPlayerGamepoints(),"0","P2 set score is still 0")
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"0","P1 points resets to 0")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"0","P1 points resets to 0")
        
    }
    func testThreeThreeScoreGames(){
        for _ in 0..<3{
            straightWinGameP1()
            straightWinGameP2()
        }
        XCTAssertEqual(LogicController.state.player1.getPlayerGamepoints(),"3","P1 games score is now 3")
        XCTAssertEqual(LogicController.state.player2.getPlayerGamepoints(),"3","P2 games score is now 3")
        XCTAssertFalse(LogicController.state.set_.complete()) //  game not complete
        XCTAssertFalse(LogicController.state.isInTieBreak) //  game not complete
    }
    func testFiveFiveScoreGames(){
       
        for _ in 0..<5{
            straightWinGameP1()
            straightWinGameP2()
        }
        XCTAssertEqual(LogicController.state.player1.getPlayerGamepoints(),"5","P1 games score is now 5")
        XCTAssertEqual(LogicController.state.player2.getPlayerGamepoints(),"5","P2 games score is now 5")
        XCTAssertFalse(LogicController.state.set_.complete()) //  game not complete
        XCTAssertFalse(LogicController.state.isInTieBreak) //  game not complete
    }
    func testwinSetBySevenFive(){
        
        for _ in 0..<5{// win five games each
            straightWinGameP1()
            straightWinGameP2()
        }
        for _ in 0..<2{
            straightWinGameP1()
        }
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpoints(),"1","P1 set score is now 1")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpoints(),"0","P2 set score is still 0")
        XCTAssertEqual(LogicController.state.player1.getPlayerGamepoints(),"0","P1 games score resets to  0")
        XCTAssertEqual(LogicController.state.player2.getPlayerGamepoints(),"0","P2 games score resets to  0")
        XCTAssertFalse(LogicController.state.set_.complete()) //  game not complete
        XCTAssertFalse(LogicController.state.isInTieBreak) //  game not complete
    }
    
    func testinTieBreakSetSixSix(){
      
        getToTieBreaker()
        XCTAssertTrue(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerGamepoints(),"6","P1 set score is now 6")
        XCTAssertEqual(LogicController.state.player2.getPlayerGamepoints(),"6","P2 set score is now 6")
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"0","P1 set score is now 0")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"0","P2 set score is now 0")
       
    }
    func testTieBreakScoreOnPointsThree(){
        getToTieBreaker()
        for _ in 0..<3{
            addPointPlayer1()
        }
        XCTAssertTrue(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"3","P1 set score is now 3")
       
    }
    func testTieBreakScoreFiveFive(){
    
        getToTieBreaker()
        for _ in 0..<5{
            addPointPlayer1()
            addPointPlayer2()
        }
        XCTAssertTrue(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"5","P1 tie breaker score is now 5")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"5","P2 tie breaker score is now 5")
       
    }
    func testTieBreakScoreWinSevenFive(){
       
        getToTieBreaker()
        for _ in 0..<5{
            addPointPlayer1()
            addPointPlayer2()
        }
   
        addPointPlayer1()
        addPointPlayer1() // win tie breaker
      
        XCTAssertFalse(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"0","P1 tie breaker score is now 3")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"0","P2 tie breaker score is now 5")
       
    }
    func testTieBreakAndBackToNormalScoring(){
       
        getToTieBreaker()     //0   6   0
                              //0   6   0
        for _ in 0..<5{
            addPointPlayer1()     //0   6   5
                                  //0   6   5
            addPointPlayer2()
        }
   
        addPointPlayer1()                          //0   6   7
        addPointPlayer1() // win tie breaker       //0   6   5
        
        addPointPlayer2()
        addPointPlayer2() //player wins two normal points after tie break is over
      
        XCTAssertFalse(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"0","P1 points is 0")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"30","P2 points is 30")
       
    }
    func testWinSetAfterTieBreak(){
        
        getToTieBreaker()     //0   6   0
                              //0   6   0
        for _ in 0..<7{
            addPointPlayer1()     //0   6   7
                                  //0   6   0
         
        }
   
        XCTAssertFalse(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpoints(),"1","P1 Set score is now 1")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpoints(),"0","P2 Set score is now 0")
       
    }
    func testGameAndSetGoesToZeroAfterWinningMatch(){
        
        getToTieBreaker()     //0   6   0   in tie breaker
        for _ in 0..<7{       //0   6   0
            
            addPointPlayer1()     //0   6   7
                                  //0   6   0
         
        }
        //player 1 wins Tiebreak
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpoints(),"1","P1 wins set by winning tiebreak")
        XCTAssertFalse(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"0","P1  points reset to  0")
        XCTAssertEqual(LogicController.state.player2.getPlayerGamepoints(),"0","P2 Game points reset to 0 ")
      
        XCTAssertEqual(LogicController.state.player1.getPlayerGamepoints(),"0","P1 Game points reset to 0")
        addPointPlayer1()
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"15","P1  points resumes normal increments 0-15-30-40 from using tiebreaker points")
    }
    func testTieBreakContinuesTillTwoPointMargin(){
        
        getToTieBreaker()     //0   6   0   in tie breaker
        for _ in 0..<13{       //0   6   0
            addPointPlayer1()
            addPointPlayer2()
                                  
        }
        //0   6   13
        //0   6   13
      
        XCTAssertTrue(LogicController.state.isInTieBreak)
        XCTAssertEqual(LogicController.state.player1.getPlayerPoints(),"13","P1 tie breaker score is now 13")
        XCTAssertEqual(LogicController.state.player2.getPlayerPoints(),"13","P1 tie breaker score is now 13")
      
        XCTAssertEqual(LogicController.state.player1.getPlayerGamepoints(),"6","P1 tie breaker score is now 6")
        XCTAssertEqual(LogicController.state.player2.getPlayerGamepoints(),"6","P1 tie breaker score is now 6")
       
    }
    func testStriaghtWinMatch(){
        
        straightWinSetP1()
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpoints(),"1","P1 wins 1 set")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpoints(),"0","P2 didnt win a set ")
    }
    func testTwoTwoMatchScore(){
        
        for _ in 0..<2{
            straightWinSetP1()
            straightWinSetP2()
        }// both players win 2 sets each
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpoints(),"2","P1 wins 2 Sets ")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpoints(),"2","P2 wins 2Sets")
        XCTAssertFalse(LogicController.state.match.complete()) // match is complete
        
    }

    func testStraightWinMatchP1(){
        
        for _ in 0..<3{
            straightWinSetP1()
        }
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpoints(),"0","P1 wins match and match score resets to 0")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpoints(),"0","P1 wins match and match scores resets to 0")
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpointsFinal(),"3","P1 Wins match and final score is 3")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpointsFinal(),"0","P2 losses and final score is 0")
        XCTAssertEqual(LogicController.state.playerWinnerName,"Player :1","P1 won and name should be displayed")
        XCTAssertFalse(LogicController.state.match.complete())
        XCTAssertTrue(LogicController.state.gameDone)   // game is over
        XCTAssertFalse(LogicController.state.isInTieBreak)// game state is not in tiebreaker
    }
    func testWInMatchThreeTwoP2(){
       
        for _ in 0..<2{
            straightWinSetP1() // win a set 2 | 2
            straightWinSetP2()
        }
        straightWinSetP2()//win set 2-3
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpoints(),"0","P1 wins match and match score resets to 0")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpoints(),"0","P1 wins match and match scores resets to 0")
        XCTAssertEqual(LogicController.state.player1.getPlayerSetpointsFinal(),"2","P1 Score after losing 2-3 and match is over")
        XCTAssertEqual(LogicController.state.player2.getPlayerSetpointsFinal(),"3","P2 Score after winning 2-3 and match is over")
        XCTAssertEqual(LogicController.state.playerWinnerName,"Player :2","P2 won and name should be displayed")
        XCTAssertFalse(LogicController.state.match.complete())
        XCTAssertTrue(LogicController.state.gameDone)   // game is over
        XCTAssertFalse(LogicController.state.isInTieBreak)
    }
    func testNumberOfGamesPlayed(){
        
        for _ in 0..<3{
            straightWinGameP1()
            straightWinGameP2()
        }
        XCTAssertEqual(LogicController.state.numberOfGamesPlayed,6,"Six games have been played in total")
        // win 3 next games to win set
        for _ in 0..<3{
            straightWinGameP1()
        }
        XCTAssertEqual(LogicController.state.numberOfGamesPlayed,9,"Nine games have been played in total")
    }
    func testRequestNewBallAfterFirstSevenGames(){
        for _ in 0..<3{
            straightWinGameP1()
            straightWinGameP2() //3 | 3 games
        }
        straightWinGameP1() //4 | 3
        XCTAssertTrue(LogicController.state.shouldAskForNewBall)
    }
    func testRequestNewBallAfterFirstSIXGames(){
        for _ in 0..<3{
            straightWinGameP1()
            straightWinGameP2()
        }
    
        XCTAssertFalse(LogicController.state.shouldAskForNewBall)
    }
    func testRequestNewBallAfterFirst9GamesAfter7(){
        straightWinSetP1() // 6 games
        straightWinSetP2() // 6 games
        for _ in 0..<4{
            straightWinGameP1()
        }
    
        XCTAssertTrue(LogicController.state.shouldAskForNewBall)
        XCTAssertEqual(LogicController.state.numberOfGamesPlayed,16,"Nine games have been played in total after the first 7")

    }
    func testRequestNewBallAfterFirst15Games(){
        straightWinSetP1() // 6 games
        straightWinSetP1() // 6 games  12
        for _ in 0..<3{
            straightWinGameP1()
        }
    
        XCTAssertFalse(LogicController.state.shouldAskForNewBall)
        XCTAssertEqual(LogicController.state.numberOfGamesPlayed,15,"15 games have been played in total and doesnt resquire new ball till 16")

    }

    func testFirstServer(){

        XCTAssertEqual(LogicController.state.playerToServe,1,"Player 1 initially serves")
        XCTAssertTrue(LogicController.state.player1.toServe)
    }
    func testAlternateServerAfterOneGameP1Wins(){
        straightWinGameP1()
        XCTAssertEqual(LogicController.state.playerToServe,2,"Alternate server after every game so switch to player 2 regradles of who won")

    }
    func testAlternateServerAfterOneGameP2Wins(){
        straightWinGameP1()
        XCTAssertEqual(LogicController.state.playerToServe,2,"Alternate server after every game so switch to player 2 regradles of who won")

    }
    func testAlternateServerAfter5GamesP2Wins(){
        for _ in 0..<5{
            straightWinGameP1()
        }
        XCTAssertEqual(LogicController.state.playerToServe,2,"Alternate server after every game so switch to player 2")

    }
    func testAlternateServerTieBreaker(){
        getToTieBreaker() // player 2 caused tie breaker so player 2 serves first
        XCTAssertEqual(LogicController.state.playerToServe,2,"Player 2 causes Tie Break so serves first")
        addPointPlayer1()// player 1 now serves 1 | 0
        XCTAssertEqual(LogicController.state.playerToServe,1,"After first player to serve in tie break alternate to player 1")
        addPointPlayer1()// player 1 still serves twice
        //2 | 0
        XCTAssertEqual(LogicController.state.playerToServe,1,"Player 1 serves again before alternating")
        //3 | 0
        addPointPlayer1()// player 2  serves now
        XCTAssertEqual(LogicController.state.playerToServe,2,"After 2 Games player to serve in tie break alternate to player 2")
        //3 | 1
        addPointPlayer2()// player 2 still serves now
        XCTAssertEqual(LogicController.state.playerToServe,2,"Player 2 serves again before alternating")
        //4 | 1
        addPointPlayer1()// player 1 still serves now
        XCTAssertEqual(LogicController.state.playerToServe,1,"After 2 Games player to serve in tie break alternate to player 1")
        addPointPlayer2()
        addPointPlayer2() //4 | 3
        addPointPlayer1()
        addPointPlayer1() //6 | 3 tie break over  and player 2 served first during tiebreak
        //so player 1 serves now
        XCTAssertEqual(LogicController.state.playerToServe,1,"Player 2 serves first during tie break so Player 1 serves")
        

    }


}
