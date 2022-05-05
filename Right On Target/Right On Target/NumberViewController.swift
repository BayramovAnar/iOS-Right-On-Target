//
//  ViewController.swift
//  Right On Target
//
//  Created by Anar Bayramov on 4/28/22.
//

import UIKit

class NumberViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var game: Game<SecretNumericValue>!
    
    //MARK: Game life-cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }
    
    //MARK: View-Model relationship


    @IBAction func checkNumber(_ sender: Any) {
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        
        if game.isGameEnded{
            showAlertWith(score: game.score)
            game.restartGame()
        }else{
            game.startNewRound()
        }
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
       }

       //MARK: View Update
       func updateLabelWithSecretNumber(newText: String){
        label.text = newText
       }

       private func showAlertWith(score: Int){
        let alert = UIAlertController(title: "Game Over", message: "You scored \(score) points", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
       }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
    

