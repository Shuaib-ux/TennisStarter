import UIKit
import AVFoundation
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var p1Button: UIButton!
    @IBOutlet weak var p2Button: UIButton!
    @IBOutlet weak var p1NameLabel: UILabel!
    @IBOutlet weak var p2NameLabel: UILabel!
    
    @IBOutlet weak var p1PointsLabel: UILabel!
    @IBOutlet weak var p2PointsLabel: UILabel!
    
    @IBOutlet weak var p1GamesLabel: UILabel!
    @IBOutlet weak var p2GamesLabel: UILabel!
    
    @IBOutlet weak var p1SetsLabel: UILabel!
    @IBOutlet weak var p2SetsLabel: UILabel!
    
    @IBOutlet weak var p1PreviousSetsLabel: UILabel!
    @IBOutlet weak var p2PreviousSetsLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    var player: AVAudioPlayer!
    var gameScores : [GameScore] = []
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
       super.viewDidLoad()
       locationManager.requestWhenInUseAuthorization()
        alertWithTF()
       if CLLocationManager.locationServicesEnabled() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
           locationManager.startUpdatingLocation()
       }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          guard let locValue: CLLocation = manager.location else { return }

        let geoCoder = CLGeocoder()
        let location:CLLocation = locValue

            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

                // Place details
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                // Location name
                let locationName = placeMark.name ?? ""
                let administrativeArea = placeMark.administrativeArea ?? ""
                let locality = placeMark.locality ?? ""
                let country = placeMark.country ?? ""
                State.location = "\(locationName) \(administrativeArea), \(locality), \(country) "
                self.updateLocation(loc: State.location )
            })
        
      }

    
    override func viewWillAppear(_ animated: Bool) {
        p1NameLabel.backgroundColor = LogicController.state.player1.uiColorPlayerServe()
        if let loaded = PersistenceManager.shared.load(){
            gameScores = loaded.scores
        }
        super.viewWillAppear(animated)
    }
    
    /********Methods*********/
    @IBAction func p1AddPointPressed(_ sender: UIButton) {
        LogicController.addPointPlayer1()
        updateUI()
        

    }
  
    
    @IBAction func p2AddPointPressed(_ sender: UIButton) {
        LogicController.addPointPlayer2()
        updateUI()
        
    }
    
    @IBAction func restartPressed(_ sender: AnyObject) {
        LogicController.restartState()
        alertWithTF()
        updateUI()
    }
    
    @IBAction func navigateToHistory(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "hist") as? HistoryViewController else{
            print("failed to instantiate class")
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    func playSound() {
          let url = Bundle.main.url(forResource: "Sound", withExtension: "wav")
          player = try! AVAudioPlayer(contentsOf: url!)
          player.play()
       }
    func askForBall(){
        let speechSynthesizer = AVSpeechSynthesizer()
        // Line 2. Create an instance of AVSpeechUtterance and pass in a String to be spoken.
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: "New balls please")
        //Line 3. Specify the speech utterance rate. 1 = speaking extremely the higher the values the slower speech patterns. The default rate, AVSpeechUtteranceDefaultSpeechRate is 0.5
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        // Line 4. Specify the voice. It is explicitly set to English here, but it will use the device default if not specified.
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        // Line 5. Pass in the urrerance to the synthesizer to actually speak.
        speechSynthesizer.speak(speechUtterance)
    }
    func saveGame(){
        let gameToSave =  History(scores: gameScores)
        PersistenceManager.shared.save(history: gameToSave)
    }
    func addToGame(player1Score:String, player2Score: String, player1Name:String, player2Name:String){
        let score = GameScore(player1Score: player1Score, player2Score: player2Score, location: State.location, date_: State.getCurrentDate(),player1Name_:player1Name,player2Name_:player2Name)
        gameScores.insert(score, at: 0)

    }
    func alertWithTF() {
        //Step : 1
        let alert = UIAlertController(title: "Names", message: "Please Enter Players Names", preferredStyle: UIAlertController.Style.alert )
        //Step : 2
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField1 = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            if textField1.text != "" {
                //Read TextFields text data
                
                LogicController.state.player1.fullPlayerName = textField1.text ?? "Player 1"
                self.p1NameLabel.text = LogicController.state.player1.fullPlayerName
            }

            if textField2.text != "" {
                
                LogicController.state.player2.fullPlayerName = textField2.text ?? "Player 2"
                self.p2NameLabel.text = LogicController.state.player2.fullPlayerName
            } 
        }

        //Step : 3
        //For first TF
        alert.addTextField { (textField) in
            textField.placeholder = "Player 1"
            textField.textColor = .red
        }
        //For second TF
        alert.addTextField { (textField) in
            textField.placeholder = "Player 2"
            textField.textColor = .blue
        }

        //Step : 4
        alert.addAction(save)
        //Cancel action
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        //OR single line action
        //alert.addAction(UIAlertAction(title: "Cancel", style: .default) { (alertAction) in })

        self.present(alert, animated:true, completion: nil)

    }
   
    func updateLocation(loc:String){
        DispatchQueue.main.async { [weak self] in
            self?.locationLabel.text=loc
        }
    }
    func updateUI(){
        DispatchQueue.main.async { [weak self] in
            
            if (LogicController.state.ifServiceChangedAfterGainingPoint){
                self?.playSound()
            }
            if (LogicController.state.shouldAskForNewBall){
                self?.askForBall()
            }
          
            self?.p1NameLabel.backgroundColor = LogicController.state.player1.uiColorPlayerServe()
            self?.p2NameLabel.backgroundColor = LogicController.state.player2.uiColorPlayerServe()
            
            
            
            self?.p1PointsLabel.backgroundColor = LogicController.state.player1.uiColorPoints(points:LogicController.state.player1.getPlayerPoints())
            self?.p2PointsLabel.backgroundColor = LogicController.state.player2.uiColorPoints( points: LogicController.state.player2.getPlayerPoints())
           self?.p1GamesLabel.backgroundColor = LogicController.state.player1.uiColorPoints(points: LogicController.state.player1.getPlayerGamepoints())
            self?.p2GamesLabel.backgroundColor = LogicController.state.player2.uiColorPoints(points: LogicController.state.player2.getPlayerGamepoints())
            self?.p1SetsLabel.backgroundColor = LogicController.state.player1.uiColorPoints(points: LogicController.state.player1.getPlayerSetpoints())
            self?.p2SetsLabel.backgroundColor = LogicController.state.player2.uiColorPoints(points:
                LogicController.state.player2.getPlayerSetpoints())
            
           
            self?.p1PointsLabel.text = LogicController.state.player1.getPlayerPoints()
            self?.p2PointsLabel.text = LogicController.state.player2.getPlayerPoints()
            self?.p1GamesLabel.text = LogicController.state.player1.getPlayerGamepoints()
            self?.p2GamesLabel.text = LogicController.state.player2.getPlayerGamepoints()
            self?.p1SetsLabel.text = LogicController.state.player1.getPlayerSetpoints()
            self?.p2SetsLabel.text = LogicController.state.player2.getPlayerSetpoints()
            self?.p1PreviousSetsLabel.text = LogicController.state.player1.getPlayerSetpointsFinal()
            self?.p2PreviousSetsLabel.text = LogicController.state.player2.getPlayerSetpointsFinal()
            
            if LogicController.state.gameDone{
                self?.addToGame(player1Score: LogicController.state.player1.getPlayerSetpointsFinal(), player2Score: LogicController.state.player2.getPlayerSetpointsFinal(),player1Name:LogicController.state.player1.fullPlayerName,player2Name:LogicController.state.player2.fullPlayerName)
                self?.saveGame()
                self?.p1Button.isEnabled=false
                self?.p2Button.isEnabled=false
                
                let alert:UIAlertController = UIAlertController(title: "Congratulations", message: LogicController.state.playerWinnerName+" WINS!!", preferredStyle: .alert)
                let cancelAction:UIAlertAction=UIAlertAction(title: "OK Thanks", style: .cancel){
                    action->Void in
                }
                alert.addAction(cancelAction)
                self?.present(alert, animated: true, completion:nil)
            }else{
                
                self?.p1Button.isEnabled=true
                self?.p2Button.isEnabled=true
            }
            


        }
    }
    
}

