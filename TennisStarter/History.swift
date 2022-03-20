

import Foundation

struct GameScore: Hashable,Codable{
    var id = UUID()
    let player1Score: String
    let player2Score: String
    let location: String
    var date_:String
    let player1Name_:String
    let player2Name_:String
    
    
}


struct History:Codable{
    let scores:[GameScore]
}

