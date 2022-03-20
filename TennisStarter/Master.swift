////
////  Master.swift
////  TennisStarter
////
//
////  Copyright © 2022 University of Chester. All rights reserved.
////
//
//
//class MasterContoller{
//    
//    
//    static var game: Game = Game()
//    static var set_ : Set_ = Set_()
//    static var match: Match = Match()
//    static var tieBreakercntrl:tieBreaker = tieBreaker()
//    
//    static var state : State = State()
//   
//
//   
//    
//    static func addPointPlayer1(){
//        MasterContoller.addPoint(currentPlayer : MasterContoller.state.player1, advesary: MasterContoller.state.player2)
//    }
//    
//    static func addPointPlayer2(){
//        MasterContoller.addPoint(currentPlayer : MasterContoller.state.player2, advesary: MasterContoller.state.player1)
//
//    }
//    static func restartState(){
//        state = State()
//        
//    }
//    
//    
//    
//    static func alternateServer(){
//        MasterContoller.state.ifServiceChangedAfterGainingPoint=true
//        if MasterContoller.state.playerToServe==1{
//            MasterContoller.state.playerToServe=2
//            MasterContoller.state.player1.toServe=false
//            MasterContoller.state.player2.toServe=true
//        }else{
//            MasterContoller.state.playerToServe=1
//            MasterContoller.state.player2.toServe=false
//            MasterContoller.state.player1.toServe=true
//        }
//    }
//    
//
//    static func addPoint(currentPlayer: Player,advesary:Player){
//        
//        MasterContoller.state.ifServiceChangedAfterGainingPoint=false
//        
//        if(!MasterContoller.state.isInTieBreak){  //if not a tie breaker match
//            
//            currentPlayer.addPoint(game: MasterContoller.game) //add point to player
//                            
//            if(currentPlayer.wonGame(game: MasterContoller.game)){ //if the game is won after gaining point
//               
//                MasterContoller.state.addTonumberOfGamesPlayed()
//                currentPlayer.addGamePoints(set_: MasterContoller.set_)  // if game is won add point to game following game point rules
//                    
//                if(set_.isTieBreaker()){ //if winning game puts you in tie breaker update state reflecting tiebraker aas true
//                    MasterContoller.state.isInTieBreak=true
//                    MasterContoller.state.firstToServeTieBreaker=MasterContoller.state.playerToServe
//                    
//                }else{   // if gaining point didnt put you in tie breaker mode
//                    MasterContoller.alternateServer()
//                    if(currentPlayer.wonSet(set_: set_)){ // if set was won from wining a  game
//                        
//                                currentPlayer.addSetPoints(match: MasterContoller.match) //add point to set
//                                currentPlayer.updateSetPoints(match: MasterContoller.match) // update state to reflect player set
//                                
//                                if(MasterContoller.match.matchComplete()){ // if match was won from winning set
//                                    
//                                    updateAfterWininningMatch(currentPlayer: currentPlayer, advesary: advesary)
//                                    
//                                }
//                                set_=Set_()//reset set state
//                            }
//                           
//                        }
//                    
//                    currentPlayer.updateGamePoints(set_: MasterContoller.set_)
//                    advesary.updateGamePoints(set_: MasterContoller.set_)
//                    game = Game()
//                }
//                //reset game state
//            
//            currentPlayer.updatePoints(game: MasterContoller.game)
//            advesary.updatePoints(game: MasterContoller.game)
//            
//            
//        }else{//if in tie break then we actually edit the player points not game and the rules for updating the ui is diffrent
//            
//            currentPlayer.addTieBreakerPoints(tiebreaker: MasterContoller.tieBreakercntrl)
//            
//            currentPlayer.updateTieBreakerPoints(tiebreaker: MasterContoller.tieBreakercntrl)
//            
//            //only alternate server after first serve
//            
//            if (MasterContoller.tieBreakercntrl.numberOfMatches()==1){
//                MasterContoller.alternateServer()
//            }
//            else if ((MasterContoller.tieBreakercntrl.numberOfMatches()-1) % 2==0){
//                
//                MasterContoller.alternateServer()
//            }
//            
//            if(MasterContoller.tieBreakercntrl.timeBreakComplete()){
//                MasterContoller.state.addTonumberOfGamesPlayed()
//               updateStateAfterTieBreaks(currentPlayer: currentPlayer, advesary: advesary)
//                
//            }
//        }
//       
//    }
//    
//    
//    static func updateStateAfterTieBreaks(currentPlayer: Player,advesary:Player){
//        
//        //In singles, the player that started serving the tie-break will receive during the first game of the next set.
//        //so we get the player that served first and then call the alternate player fuction
//        
//        MasterContoller.state.playerToServe = MasterContoller.state.firstToServeTieBreaker
//        MasterContoller.alternateServer()
//        
//        MasterContoller.state.isInTieBreak=false
//        currentPlayer.playerpoints="0"
//        advesary.playerpoints="0"
//        
//        currentPlayer.addSetPoints(match: MasterContoller.match)
//        currentPlayer.updateSetPoints(match: MasterContoller.match)
//        
//        if(MasterContoller.match.matchComplete()){
//            updateAfterWininningMatch(currentPlayer: currentPlayer, advesary: advesary)
//        }
////
//        tieBreakercntrl=tieBreaker() //reset tiebreak state
//        set_=Set_() //reset set state
//        currentPlayer.updateGamePoints(set_: MasterContoller.set_)
//        advesary.updateGamePoints(set_: MasterContoller.set_)
//        
//    }
//    static func updateAfterWininningMatch(currentPlayer: Player,advesary:Player){
//        currentPlayer.updateSetScoresfinal(match: MasterContoller.match)
//        advesary.updateSetScoresfinal(match: MasterContoller.match)
//        
//        set_=Set_()
//        match=Match()
//        game=Game()
//        currentPlayer.updateGamePoints(set_: MasterContoller.set_)
//        advesary.updateGamePoints(set_: MasterContoller.set_)
//        
//        currentPlayer.updatePoints(game: MasterContoller.game)
//        advesary.updatePoints(game: MasterContoller.game)
//        
//        currentPlayer.updateSetPoints(match: MasterContoller.match)
//        advesary.updateSetPoints(match: MasterContoller.match)
//        
//        MasterContoller.state.playerWinnerName = currentPlayer.fullPlayerName
//        MasterContoller.state.gameDone=true
//    }
//    
//}
