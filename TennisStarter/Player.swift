
import UIKit


class Player{
    var name:Int
    var fullPlayerName : String
    var minmumPlayerPoints = AppConstants.defaultScore
    private var playerpoints = AppConstants.defaultScore
    private var playerGamepoints = AppConstants.defaultScore
    private var playerSetpoints = AppConstants.defaultScore
    private var playerSetpointsfinal = AppConstants.defaultScore
    var toServe = false
    
    
    init(id:Int){
        name = id
        fullPlayerName = "Player :"+String(name)
    }
    func getPlayerName()->String{
        return fullPlayerName
    }
    func getPlayerPoints()->String{
        return playerpoints
    }
    func getPlayerGamepoints()->String{
        return playerGamepoints
    }
    func getPlayerSetpoints()->String{
        return playerSetpoints
    }
    func getPlayerSetpointsFinal()->String{
        return playerSetpointsfinal
    }
    // functions to add points  start
    func addPoint(game:Game){
        if (name==1){
            game.addPointToPlayer1()
        }else if(name==2){
            game.addPointToPlayer2()
        }
    }
    func addGamePoints(set_:Set_){
        if (name==1){
            set_.addScoreToPlayer1()
        }else if(name==2){
            set_.addScoreToPlayer2()
        }
    }
    func addSetPoints(match : Match){
        if (name==1){
            match.addScoreToPlayer1()
        }else if(name==2){
            match.addScoreToPlayer2()
        }
    }
    func addTieBreakerPoints(tiebreaker: tieBreaker){
        if (name==1){
            tiebreaker.addScoreToPlayer1()
        }else if(name==2){
            tiebreaker.addScoreToPlayer2()
        }
    }
    // functions to add points  End
    
    
    func wonGame(game:Game) -> Bool{
        if (name==1){
            return game.player1Won()
        }else if(name==2){
            return game.player2Won()
        }
        else{
            return false
        }
    }
    
    // functions to update player state starts
    func updatePoints(game:Game){
        if (name==1){
            playerpoints = game.player1Score()
        }else if(name==2){
            playerpoints=game.player2Score()
        }
       
    }
    func updateGamePoints(set_ : Set_){
        if (name==1){
            playerGamepoints = set_.player1Score()
        }else if(name==2){
            playerGamepoints = set_.player2Score()
        }
    }
    func updateSetPoints(match : Match){
        if (name==1){
            playerSetpoints = match.player1Score()
        }else if(name==2){
            playerSetpoints =  match.player2Score()
        }
        
    }
    func updateSetScoresfinal(match : Match){
        if (name==1){
            playerSetpointsfinal = match.player1Score()
        }else if(name==2){
            playerSetpointsfinal =  match.player2Score()
        }
    }
  
    func updateTieBreakerPoints(tiebreaker: tieBreaker){
        if (name==1){
            playerpoints = tiebreaker.player1Score()
        }else if(name==2){
            playerpoints = tiebreaker.player2Score()
        }
    }
    // functions to update player state stops
    
    
    
    func wonSet(set_ : Set_) -> Bool{
        if (name==1){
            return set_.player1Won()
        }else if(name==2){
            return set_.player2Won()
        }
        else{
            return false
        }
    }
 
   
   // fucntion to change player points back ground color
    func uiColorPoints(points : String)->UIColor{
        if (points != minmumPlayerPoints){
            return AppConstants.pointsColor
        }else{
            return  AppConstants.ColorDefault
        }
    }
   
    // fucntion to change player points back ground color end
    //
    //
    //function to highlight who to serve
    func uiColorPlayerServe()->UIColor{
        if (toServe){
            return AppConstants.serveColor
        }else{
            return AppConstants.ColorDefault
        }
    }
}


