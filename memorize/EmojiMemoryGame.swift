//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by 11344113 on 3/30/26.
//

import Foundation

func createCardContent(index: Int)->String {
    return "A"
}
class EmojiMemoryGame{
    private var model: memoryGame<String> = memoryGame<String>(numberOfPairsOfCards:4, createCardContent: createCardContent)
    
    var cards: [memoryGame<String>.Card] {
        model.cards
    }
}
