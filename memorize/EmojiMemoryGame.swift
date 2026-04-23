//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by 11344113 on 3/30/26.
//

import SwiftUI

@Observable
class EmojiMemoryGame {

    // MARK: - Theme 建立
    private static func createThemePool() -> ThemePool<String> {
        var pool = ThemePool<String>()
        // 新增最少三個不同的 Theme
        pool.addTheme(
            ThemePool<String>
                .Theme(
                    name: "字母",
                    color: "cyan",
                    numberOfPairs: 8,
                    items: [
                        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
                        "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
                        "W", "X", "Y", "Z",
                    ]
                )
        )
        pool.addTheme(
            ThemePool<String>.Theme(
                name: "可愛動物",
                color: "blue",
                numberOfPairs: 8,
                items: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
            )
        )
        pool.addTheme(
            ThemePool<String>.Theme(
                name: "球類運動",
                color: "green",
                numberOfPairs: 6,
                items: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓"]
            )
        )
        return pool
    }

    private static func createMemoryGame(with theme: ThemePool<String>.Theme)
        -> memoryGame<String>
    {
        // 隨機提供 items 內容，避免每次都只取前面幾個 Emoji
        let shuffledItems = theme.items.shuffled()
        // 確保 numberOfPairs 不會超過 items 的數量
        let pairs = min(theme.numberOfPairs, shuffledItems.count)

        return memoryGame<String>(numberOfPairsOfCards: pairs) { index in
            shuffledItems[index]
        }
    }

    private var themePool: ThemePool<String>
    private(set) var currentTheme: ThemePool<String>.Theme
    private var model: memoryGame<String>

    // MARK: - 自訂 init 以控制建立順序
    init() {
        let pool = EmojiMemoryGame.createThemePool()
        self.themePool = pool

        // 隨機選擇一個 Theme
        let randomTheme = pool.themes.randomElement()!
        self.currentTheme = randomTheme

        // 將選擇的 Theme 帶入建立遊戲
        self.model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
    }

    var cards: [memoryGame<String>.Card] {
        model.cards
    }

    // 取得分數
    var score: Int {
        model.score
    }

    var themeName: String {
        currentTheme.name
    }

    // 將字串顏色轉換為 SwiftUI 的 Color
    var themeColor: Color {
        switch currentTheme.color {
        case "cyan": return .cyan
        case "blue": return .blue
        case "green": return .green
        default: return .gray
        }
    }

    // MARK: - Intent Functions
    func choose(_ card: memoryGame<String>.Card) {
        model.choose(card)
    }

    func shuffle() {
        model.shuffle()
    }

    // 重新開始一個全新遊戲
    func newGame() {
        if let randomTheme = themePool.themes.randomElement() {
            currentTheme = randomTheme
            model = EmojiMemoryGame.createMemoryGame(with: randomTheme)
        }
    }
}
