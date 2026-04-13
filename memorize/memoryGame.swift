//
//  memoryGame.swift
//  memorize
//
//  Created by 11344113 on 3/30/26.
//

import Foundation

struct memoryGame<CardContent> where CardContent: Equatable{
    var cards: [Card]
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = []
        for index in 0..<numberOfPairsOfCards{
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id: "\(index)a"))
            cards.append(Card(content: cardContent, id: "\(index)b"))
        }
        shuffle()
    }
    var lastFaceupIndex: Int?
    mutating func choose(_ card: Card) {
        if let chosenIndex=index(of: card){
            if let lastIndex=lastFaceupIndex{
                if cards[lastIndex].content == cards[chosenIndex].content{
                    cards[lastIndex].ismatched=true
                    cards[chosenIndex].ismatched=true
                }
                lastFaceupIndex=nil
            }else{
                for i in 0..<cards.count{
                    cards[i].isFaceUp=false
                }
                lastFaceupIndex=chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("cards:\(cards)")
    }
    func index(of card: Card) -> Int?{
        for i in 0..<cards.count{
            if cards[i] == card{
                return i
            }
        }
        return nil
    }
    mutating func shuffle() {
        cards.shuffle()
        print("shuffle cards:\(cards)")
    }
    
    struct Card: Equatable, Identifiable{
        
        static func == (lhs: memoryGame<CardContent>.Card, rhs: memoryGame<CardContent>.Card) -> Bool {
            lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.ismatched == rhs.ismatched && lhs.id == rhs.id
        }
        
        
        var isFaceUp: Bool = false
        var ismatched: Bool = false
        var content: CardContent
        var id: String
        }
    }

