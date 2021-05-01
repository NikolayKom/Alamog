//
//  Game.swift
//  Alamog
//
//  Created by Николай on 25.04.2021.
//

import Foundation
class Game {
    var cards = [Card]()
    
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly

        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMathed {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard,
               matchingIndex != index {
                if cards[matchingIndex] == cards[index] {
                    cards[matchingIndex].isMathed = true
                    cards[index].isMathed = true
                }
                cards[index].isFaceUp = true
            } else {
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

extension Collection {
    
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
    
}
