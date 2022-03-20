
import Foundation

class State {
    
    var player1 : Player
    var player2 : Player
    
    var game: Game = Game()
    var set_ : Set_ = Set_()
    var match: Match = Match()
    var tieBreakercntrl:tieBreaker = tieBreaker()
    static var location =   "No location"
    var playerToServe : Int
    init(){
        player1  = Player(id: 1)
        player2  = Player(id: 2)
        playerToServe = player1.name
        player1.toServe=true
    }
  
    
    var firstToServeTieBreaker: Int = 0
    var playerWinnerName :String = ""
    var isInTieBreak = false
    var gameDone = false
    var ifServiceChangedAfterGainingPoint = false
    var shouldAskForNewBall = false
    var numberOfGamesPlayed = 0
    
    static func getCurrentDate()->String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    func resetGame(){
        game=Game()
    }
    func resetSet(){
        set_=Set_()
    }
    func resetMatch(){
        match=Match()
    }
   
    func resetTieBreaker(){
        tieBreakercntrl=tieBreaker()
    }
    
    func updateNewballsRequest(){
        // 7 games have been played initially then request
        if   (numberOfGamesPlayed==AppConstants.minGamesToRequestBall){
            shouldAskForNewBall=true
            // if after 7 games have been pplayed request ball every 9 games
        }else if (numberOfGamesPlayed>AppConstants.minGamesToRequestBall && ((numberOfGamesPlayed - AppConstants.minGamesToRequestBall) % AppConstants.numberGamesToRequestBall)==0){
            shouldAskForNewBall=true
        }
    }
    func addTonumberOfGamesPlayed(){
        //function to simply add to number of games played
        numberOfGamesPlayed += 1
    }
    
  
}
