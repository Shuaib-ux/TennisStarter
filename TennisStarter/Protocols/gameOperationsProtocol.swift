
import Foundation
protocol operationsProtocol{
    
    func addScoreToPlayer1()
    func addScoreToPlayer2()
    func player1Score() -> String
    func player2Score() -> String
    func player1ScoreVal() -> Int
    func player2ScoreVal() -> Int
    func player1Won() -> Bool
    func player2Won() -> Bool
    func complete() ->Bool
    
}
