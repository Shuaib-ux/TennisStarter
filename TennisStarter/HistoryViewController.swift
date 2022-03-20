
import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource{
    var gameScores : [GameScore] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistTableViewCell
        let data = gameScores[indexPath.row]
        cell.player1Score.text=data.player1Score
        cell.player2Score.text=data.player2Score
        cell.Location.text=data.location
        cell.Date.text=data.date_
        cell.player1Name.text=data.player1Name_
        cell.player2Name.text=data.player2Name_
        return cell
    }
    
    @IBOutlet weak var table:  UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loaded = PersistenceManager.shared.load(){
            gameScores = loaded.scores
        }
        table.dataSource=self

        // Do any additional setup after loading the view.
    }
    

}
