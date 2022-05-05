//
//  NumberViewController.swift
//  Right On Target
//
//  Created by Anar Bayramov on 5/2/22.
//

import UIKit

class ColorViewController: UIViewController {
    
    var game: Game<SecretColorValue>!
    var correctButtonTag: Int = 0
    
    @IBOutlet weak var hexLabel: UILabel!
    

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var buttonColor1: UIButton!
    @IBOutlet weak var buttonColor2: UIButton!
    @IBOutlet weak var buttonColor3: UIButton!
    @IBOutlet weak var buttonColor4: UIButton!
    
    
    
    var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonCollection = [buttonColor1, buttonColor2, buttonColor3, buttonColor4]
        updateScene()
    }
    
    private func updateScene(){
        let secretColorString = game.secretValue.value.getByHEXString()
        updateSecretColorLabel(withText: secretColorString)
        updateButtons(withRightSecretValue: game.secretValue)
    }
    
    
    
    
    
    
    
    @IBAction func compareValue(sender: UIButton){
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
        game.calculateScore(secretValue: game.secretValue, userValue: userValue)
        
        if game.isGameEnded{
            showAlertWith(score: game.score)
            game.restartGame()
        }else{
            game.startNewRound()
        }
        updateScene()
    }

    
    private func updateSecretColorLabel(withText newHEXColorText: String ){
        hexLabel.text = "#\(newHEXColorText)"
    }
    
    private func updateButtons(withRightSecretValue secretValue: SecretColorValue){
        correctButtonTag = Array(1...4).randomElement()!
        buttonCollection.forEach{ button in
            if button.tag == correctButtonTag{
                button.backgroundColor = secretValue.value.getByUIColor()
            }else{
                var copySecretValueForButton = secretValue
                copySecretValueForButton.setRandomValue()
                button.backgroundColor = copySecretValueForButton.value.getByUIColor()
            }
        }
    }
    
    private func showAlertWith(score: Int){
        let alert = UIAlertController(title: "Game Over", message: "You scored \(score) scores", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
