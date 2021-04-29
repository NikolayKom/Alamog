//
//  Card.swift
//  Alamog
//
//  Created by Николай on 25.04.2021.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMathed = false
    var identifier: Int
    
    static  var identifierNumber = 0
    
    static func identifierGenerator() -> Int {
        identifierNumber += 1
        return identifierNumber
    }
    
    init() {
        self.identifier = Card.identifierGenerator()
    }
}
