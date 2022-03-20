class Game {
    
    /**
     This method will be called when player 1 wins a point and update the state of the instance of Game to reflect the change
     */
    private var player1GameScore:Int
    private var player2GameScore:Int
    
    init() {
        self.player1GameScore = 0
        self.player2GameScore = 0

    }
    
    
    
    func addPointToPlayer1(){
        (player1GameScore , player2GameScore)=addPoints(playerScored: player1GameScore, advesary: player2GameScore)
     
    }
    
    /**
     This method will be called when player 2 wins a point
     */
    func addPointToPlayer2(){
        (player2GameScore , player1GameScore) = addPoints(playerScored: player2GameScore, advesary: player1GameScore)
       
    }

    /**
     Returns the score for player 1, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player1Score() -> String {
        return decode(count: player1GameScore)
    }

    /**
     Returns the score for player 2, this will only ever be "0","15","30","40" or "A"
     If the game is complete, this should return an empty string
     */
    func player2Score() -> String {
        return decode(count: player2GameScore)
    }
    
    /**
     Returns true if player 1 has won the game, false otherwise
     */
    func player1Won() -> Bool{
        return Playerwin(player: player1GameScore, advesary: player2GameScore)

    }
    
    /**
     Returns true if player 2 has won the game, false otherwise
     */
    func player2Won() -> Bool{
        return Playerwin(player: player2GameScore, advesary: player1GameScore)
       
    }
    
    /**
     Returns true if the game is finished, false otherwise
     */
    func complete() ->Bool {
        return ( player1Won() || player2Won() )
          
    }
    
    /**
     If player 1 would win the game if they won the next point, returns the number of points player 2 would need to win to equalise the score, otherwise returns 0
     e.g. if the score is 40:15 to player 1, player 1 would win if they scored the next point, and player 2 would need 2 points in a row to prevent that, so this method should return 2 in that case.
     */
    func gamePointsForPlayer1() -> Int{
        return computeGamePoint(currentPlayerScore: player1GameScore, advesaryScore: player2GameScore)

    }
    
    /**
     If player 2 would win the game if they won the next point, returns the number of points player 1 would need to win to equalise the score
     */
    func gamePointsForPlayer2() -> Int {
        return computeGamePoint(currentPlayerScore: player2GameScore, advesaryScore: player1GameScore)

    }
    
    
    
    
    
    private func decode(count:Int)->String{
        //                       0   1    2    3    4  5
        let encoder: [String] = ["0","15","30","40","A",""]
        return encoder[count]
    }
    
    private func reset_(){
        player1GameScore = 0
        player2GameScore = 0
    }
    /**
     This method will be called when player 1 wins a point and update the state of the instance of Game to reflect the change
     */
    private func addPoints(playerScored: Int, advesary: Int)->(Int,Int){
        var player = playerScored
        var adv = advesary
        
        // if opponent is on advantage and player scores,then opponent's Advantage gets cancelled
        if(decode(count: adv)=="A" && decode(count: player)=="40"){
            adv-=1
        }else {
            player+=1
        }
        return (player,adv)
    }
    
    private func Playerwin(player: Int, advesary: Int)->Bool{
        // if one player is on advantage and the other  has score from 30 below or alternatively if player had an advantage and scored and extra point
        return( ( decode(count: player)=="A" && advesary < 3) ||
                (decode(count: player)=="" && decode(count: advesary)=="40"))
    }
    
    
    private func computeGamePoint(currentPlayerScore:Int, advesaryScore:Int)->Int{
        if currentPlayerScore>=3{
            return currentPlayerScore-advesaryScore
        }else{
            return 0
        }
    }
}


