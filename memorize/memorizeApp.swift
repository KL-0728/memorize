//
//  memorizeApp.swift
//  memorize
//
//  Created by 11344113 on 3/16/26.
//

import SwiftUI

@main
struct memorizeApp: App {
    var game=EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
