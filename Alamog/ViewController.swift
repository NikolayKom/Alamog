//
//  ViewController.swift
//  Alamog
//
//  Created by Николай on 25.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Game(numberOfPairsOfCards:
            (buttonCollection.count + 1)/2)
    
    var touches = 0 {
        didSet{
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    var emojiCollection = ["🌛","🌜","🌚","🌕","🌖","🌗","🌘","🌑","🌒","🌓","🌔"]
    
    var emojiDictionary = [Card:String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomIndex =
                Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card] =
                emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card] ?? "?"
    }
    
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
    

    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
}

