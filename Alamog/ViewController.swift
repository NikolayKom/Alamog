//
//  ViewController.swift
//  Alamog
//
//  Created by Николай on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    //Mark: Create game cards
    lazy var game = Game(numberOfPairsOfCards:
            (buttonCollection.count + 1)/2)
    //Mark: Set on change touches
    var touches = 0 {
        didSet{
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth: 5.0,
                .strokeColor: UIColor.red
                ]
            let attributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
            touchLabel.attributedText = attributedString
        }
    }
    
    override func viewDidLoad() {
        //undo load game loading userdefaults bestscore
        let bestScoreData = defaults.integer(forKey: "BestScore")
        bestScoreChecker(bestScoreData: bestScoreData)
        
        
    }
    let defaults = UserDefaults.standard
    var emojiCollection = ["🌛","🌜","🌚","🌕","🌖","🌗","🌘","🌑","🌒","🌓","🌔","🍄","⛅️","🌨","🌩"]
    var emojiDictionary = [Card:String]()
    //Mark: randomaize emoji
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomIndex =
                Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card] =
                emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card] ?? "?"
    }
    
    func bestScoreChecker(bestScoreData: Int) {
        if bestScoreData == 0 {
            defaults.set(9999, forKey: "BestScore")
            bestScoreLabel.text = "Best Score: 0"
        } else {
            bestScoreLabel.text = "Best Score: \(bestScoreData)"
        }
    }
    
    //Mark: Update view after click the card
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMathed ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) : #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            }
        }
    }

    //Mark: Check status game, if win reload game, compare BestScore, show notification
    func maybeWin() {
        var indexOfCards = 0
        
        for index in buttonCollection.indices {
            let card = game.cards[index]
            if card.isMathed {
                indexOfCards += 1
            }
        }
        
        
        if indexOfCards == buttonCollection.count {
            var bestScoreData = defaults.integer(forKey: "BestScore")
            indexOfCards = 0
            touchLabel.text = "You are Win!"

            
            let alert = UIAlertController(title: "You are Win!", message: "Your score: \(touches)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Next game", style: .cancel, handler: { [self]action in touches = 0}))
            self.present(alert, animated: true)
            
            for index in buttonCollection.indices {
                game.cards[index].isMathed = false
                game.cards[index].isFaceUp = false
                let button = buttonCollection[index]
                button.setTitle("", for: .normal)
                button.backgroundColor =  #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                }
          
            if touches < bestScoreData {
                defaults.set(touches, forKey: "BestScore")
                bestScoreData = defaults.integer(forKey: "BestScore")
                bestScoreLabel.text = "Best Score: \(bestScoreData)"
                print((defaults.integer(forKey: "BestScore")))
            }
                
                
                
            
        }
    }
    
    
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
            maybeWin()
        }
    }
}

