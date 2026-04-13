//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by 11344113 on 3/30/26.
//

import Foundation

@Observable
class EmojiMemoryGame{
    private static var emojis:Array<String>=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    private static func createMeomorygame() -> memoryGame<String> {
        memoryGame<String>(numberOfPairsOfCards:4,
                           createCardContent:{index in emojis[index]})
    }
    private var model: memoryGame<String> = createMeomorygame()
    
    var cards: [memoryGame<String>.Card] {
        model.cards
    }
    //Mark:- intent
    func choose(_ card:memoryGame<String>.Card){
        model.choose(card)
    }
    func shuffle(){
        model.shuffle()
    }
}
