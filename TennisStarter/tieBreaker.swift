

import Foundation
class tieBreaker : GameOperations{
    func numberOfTieBreakerMatches()->Int{
        return player1ScoreVal() + player2ScoreVal()
    }
    private func playerWinsTie(currentPlayerScore : Int, advesary: Int)->Bool{
        let pointDiffrence = currentPlayerScore - advesary
    
        return (currentPlayerScore >= 7 && pointDiffrence >= AppConstants.minScoreDiffTie )
    }

    override func player1Won()->Bool{
        return playerWinsTie(currentPlayerScore : player1ScoreVal(), advesary: player2ScoreVal())
    }

    override func player2Won()->Bool{
        return playerWinsTie(currentPlayerScore : player2ScoreVal(), advesary: player1ScoreVal())
    }


}
