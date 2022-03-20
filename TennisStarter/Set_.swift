
class Set_: GameOperations{
    private func playerWon(currentPlayerScore : Int, advesary : Int)->Bool{
        return( (currentPlayerScore == 6 && advesary <= 4) || ( currentPlayerScore==7 && advesary==5 ))
    }

    override func player1Won()->Bool{
        return playerWon(currentPlayerScore: player1ScoreVal(), advesary: player2ScoreVal())

    }
    
    override func player2Won()->Bool{
        return playerWon(currentPlayerScore: player2ScoreVal(), advesary: player1ScoreVal())

    }
    
    func isTieBreaker()->Bool{
        return (player1ScoreVal()==AppConstants.tieBreakerScore && player2ScoreVal()==AppConstants.tieBreakerScore)
    }
}
