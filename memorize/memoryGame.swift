//
//  memoryGame.swift
//  memorize
//
//  Created by 11344113 on 3/30/26.
//

import Foundation

// MARK: - 新增 ThemePool 與 Theme 模型
struct ThemePool<Item> {
    private(set) var themes: [Theme] = []
    
    mutating func addTheme(_ theme: Theme) {
        themes.append(theme)
    }
    
    struct Theme {
        let name: String
        let color: String
        let numberOfPairs: Int
        let items: [Item]
    }
}

// MARK: - Memory Game 模型
struct memoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var score: Int = 0 // 分數屬性
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = []
        for index in 0..<numberOfPairsOfCards{
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id: "\(index)a"))
            cards.append(Card(content: cardContent, id: "\(index)b"))
        }
        cards.shuffle()
    }
    
    var lastFaceupIndex: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = index(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].ismatched {
            if let lastIndex = lastFaceupIndex {
                // 翻開第二張牌
                if cards[lastIndex].content == cards[chosenIndex].content {
                    // Match：兩張都設定為 matched，+2分
                    cards[lastIndex].ismatched = true
                    cards[chosenIndex].ismatched = true
                    score += 2
                } else {
                    // Mismatch：有被看過的話扣分
                    if cards[chosenIndex].hasBeenSeen { score -= 1 }
                    if cards[lastIndex].hasBeenSeen { score -= 1 }
                }
                cards[chosenIndex].isFaceUp = true
                lastFaceupIndex = nil
            } else {
                // 翻開全新的第一張牌
                for i in 0..<cards.count {
                    if cards[i].isFaceUp {
                        cards[i].isFaceUp = false
                        cards[i].hasBeenSeen = true // 蓋牌時，標記為已看過
                    }
                }
                lastFaceupIndex = chosenIndex
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    func index(of card: Card) -> Int?{
        for i in 0..<cards.count{
            if cards[i].id == card.id {
                return i
            }
        }
        return nil
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // 拿掉自訂的 static func ==，讓系統自動判斷所有屬性變化，這樣翻牌畫面才會更新！
    struct Card: Equatable, Identifiable {
        var isFaceUp: Bool = false
        var ismatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: String
    }
}
