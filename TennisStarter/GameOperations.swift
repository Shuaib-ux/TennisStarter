

import Foundation
class GameOperations : operationsProtocol{
    
    
    private var player1CurrentScore:Int
    private var player2CurrentScore:Int
    
    
    init(){
        player1CurrentScore=0
        player2CurrentScore=0
        
    }
    func addScoreToPlayer1(){
        player1CurrentScore+=1
    }
    func addScoreToPlayer2(){
        player2CurrentScore+=1
    }
    
    func player1Score() -> String {
        return String(player1CurrentScore)
    }
    func player2Score() -> String {
        return String(player2CurrentScore)
    }
    func player1ScoreVal() -> Int {
        return player1CurrentScore
    }
    func player2ScoreVal() -> Int {
        return player2CurrentScore
    }
    func player1Won() -> Bool {
        return true
    }
    
    func player2Won() -> Bool {
        return true
    }
    
    func complete() -> Bool {
         return (player1Won() || player2Won())
    }
}
