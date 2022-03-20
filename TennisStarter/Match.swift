
import Foundation
class Match: GameOperations{
    private func playerWinsMatch(playerSetScore:Int)->Bool{
        //game is won if player reaches 3
        return( playerSetScore == AppConstants.scoreToWinMatch)
    }
    public override func player1Won()->Bool{
        playerWinsMatch(playerSetScore: player1ScoreVal())
    }
    public override func player2Won()->Bool{
        playerWinsMatch(playerSetScore: player2ScoreVal())
    }
}
