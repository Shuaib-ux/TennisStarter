
import Foundation
class LogicController{
    static var state : State = State()
   
    static func addPointPlayer1(){
        LogicController.addPoint(currentPlayer : LogicController.state.player1, advesary: LogicController.state.player2)
    }
    
    static func addPointPlayer2(){
        LogicController.addPoint(currentPlayer : LogicController.state.player2, advesary: LogicController.state.player1)

    }
    static func restartState(){
        state = State()
    }
    
    
    
    static func getState()->State{
        return state
    }
    static func alternateServer(){
        LogicController.state.ifServiceChangedAfterGainingPoint=true
        if LogicController.state.playerToServe==1{
            LogicController.state.playerToServe=2
            LogicController.state.player1.toServe=false
            LogicController.state.player2.toServe=true
        }else{
            LogicController.state.playerToServe=1
            LogicController.state.player2.toServe=false
            LogicController.state.player1.toServe=true
        }
    }
    

    static func addPoint(currentPlayer: Player, advesary:Player){
        
        LogicController.state.ifServiceChangedAfterGainingPoint=false
        LogicController.state.shouldAskForNewBall=false
        
        if(!LogicController.state.isInTieBreak){  //if not a tie breaker match
            
            currentPlayer.addPoint(game: LogicController.state.game) //add point to player
           
                            
            if(currentPlayer.wonGame(game: LogicController.state.game)){ //if the game is won after gaining point
          
               
                LogicController.state.addTonumberOfGamesPlayed()
                LogicController.state.updateNewballsRequest()
                currentPlayer.addGamePoints(set_: LogicController.state.set_)
               // if game is won add point to game following game point rules
                    
                if( LogicController.state.set_.isTieBreaker()){ //if winning game puts you in tie breaker update state reflecting tiebraker aas true
                    LogicController.state.isInTieBreak=true
                    LogicController.state.firstToServeTieBreaker=LogicController.state.playerToServe
                    
                }else{   // if gaining point didnt put you in tie breaker mode
                    LogicController.alternateServer()
                    if(currentPlayer.wonSet(set_: LogicController.state.set_)){ // if set was won from wining a  game
                        
                        currentPlayer.addSetPoints(match: LogicController.state.match) //add point to set
                        currentPlayer.updateSetPoints(match: LogicController.state.match) // update state to reflect player set
                                
                        if(LogicController.state.match.complete()){ // if match was won from winning set
                                    
                                    updateAfterWininningMatch(currentPlayer: currentPlayer, advesary: advesary)
                                    
                                }
                                LogicController.state.resetSet() //reset set state
                            }
                           
                        }
                    
                currentPlayer.updateGamePoints(set_: LogicController.state.set_)
                advesary.updateGamePoints(set_: LogicController.state.set_)
                    LogicController.state.resetGame()
                }
                //reset game state
            
            currentPlayer.updatePoints(game: LogicController.state.game)
            advesary.updatePoints(game: LogicController.state.game)

      
            
            
        }else{//if in tie break then we actually edit the player points not game and the rules for updating the ui is diffrent
            
            currentPlayer.addTieBreakerPoints(tiebreaker: LogicController.state.tieBreakercntrl)
            
            currentPlayer.updateTieBreakerPoints(tiebreaker: LogicController.state.tieBreakercntrl)
            
            //only alternate server after first serve
            
            if (LogicController.state.tieBreakercntrl.numberOfTieBreakerMatches()==1){
                LogicController.alternateServer()
            }
            else if ((LogicController.state.tieBreakercntrl.numberOfTieBreakerMatches()-1) % 2==0){
                
                LogicController.alternateServer()
            }
            
            if(LogicController.state.tieBreakercntrl.complete()){
                LogicController.state.addTonumberOfGamesPlayed()
               updateStateAfterTieBreaks(currentPlayer: currentPlayer, advesary: advesary)
                
            }
        }
       
    }
    
    
    static func updateStateAfterTieBreaks(currentPlayer: Player, advesary:Player){
        
        //In singles, the player that started serving the tie-break will receive during the first game of the next set.
        //so we get the player that served first and then call the alternate player fuction
        
        LogicController.state.playerToServe = LogicController.state.firstToServeTieBreaker
        LogicController.alternateServer()
        
        LogicController.state.isInTieBreak=false
        LogicController.state.resetGame()
        

        
        currentPlayer.addSetPoints(match: LogicController.state.match)
        currentPlayer.updateSetPoints(match: LogicController.state.match)
        
        if(LogicController.state.match.complete()){
            updateAfterWininningMatch(currentPlayer: currentPlayer, advesary: advesary)
        }
//
        LogicController.state.resetTieBreaker()//reset tiebreak state
        LogicController.state.resetSet()
        currentPlayer.updatePoints(game:LogicController.state.game)
        advesary.updatePoints(game:LogicController.state.game)
        currentPlayer.updateGamePoints(set_: LogicController.state.set_)
        advesary.updateGamePoints(set_: LogicController.state.set_)
        
    }
    static func updateAfterWininningMatch(currentPlayer: Player,advesary:Player){
        currentPlayer.updateSetScoresfinal(match: LogicController.state.match)
        advesary.updateSetScoresfinal(match: LogicController.state.match)
        
        LogicController.state.resetSet()
        LogicController.state.resetMatch()
        LogicController.state.resetGame()
       
        currentPlayer.updateGamePoints(set_: LogicController.state.set_)
        advesary.updateGamePoints(set_: LogicController.state.set_)
        
        currentPlayer.updatePoints(game: LogicController.state.game)
        advesary.updatePoints(game: LogicController.state.game)
        
    
        currentPlayer.updateSetPoints(match: LogicController.state.match)
        advesary.updateSetPoints(match: LogicController.state.match)
        
        LogicController.state.playerWinnerName = currentPlayer.getPlayerName()
        LogicController.state.gameDone=true
    }
    
}

