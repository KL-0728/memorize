//
//  memoryGame.swift
//  memorize
//
//  Created by 11344113 on 3/30/26.
//

import Foundation

struct memoryGame<CardContent>{
    var cards: [Card]
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = []
        for index in 0..<numberOfPairsOfCards{
            var cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent))
            cards.append(Card(content: cardContent))
        }
    }
    
    func choose(card: Card) {
        
    }
    struct Card{
        var isFaceUp: Bool = false
        var ismatched: Bool = false
        var content: CardContent
    }
}
