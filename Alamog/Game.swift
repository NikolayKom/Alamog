//
//  Game.swift
//  Alamog
//
//  Created by Николай on 25.04.2021.
//

import Foundation
class Game {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMathed {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard,
               matchingIndex != index {
                if cards[matchingIndex].identifier ==
                    cards[index].identifier {
                    cards[matchingIndex].isMathed = true
                    cards[index].isMathed = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = index
                }
            }
    }
    
    init(numberOfPairsOfCards:Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
