//
//  ContentView.swift
//  memorize
//
//  Created by 11344113 on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            // 頂部顯示：主題名稱 與 分數
            HStack {
                Text(viewModel.themeName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(viewModel.themeColor)
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
                    .font(.title)
                    .foregroundStyle(.red)
            }
            .padding(.horizontal)
            
            cardList
                .animation(.default, value: viewModel.cards)
            
            Spacer()
            
            // 底部按鈕區
            HStack {
                // 左下角：New Game 按鈕
                Button(action: {
                    viewModel.newGame()
                }) {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                        Text("New Game")
                            .font(.body)
                    }
                }
                
                Spacer() // 將兩個按鈕往左右推開
                
                // 右下角：Shuffle 按鈕
                Button(action: {
                    viewModel.shuffle()
                }) {
                    VStack {
                        Image(systemName: "shuffle.circle")
                            .font(.largeTitle)
                        Text("Shuffle")
                            .font(.body)
                    }
                }
            }
            .padding(.horizontal)
            .foregroundStyle(viewModel.themeColor) // 讓底部按鈕顏色跟隨主題
        }
        .padding()
    }
    
    var cardList: some View {
        ScrollView {
            LazyVGrid(columns:[GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    // 傳入對應主題的顏色
                    CardView(card: card, themeColor: viewModel.themeColor)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
    var card: memoryGame<String>.Card
    var themeColor: Color
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(Font.system(size: 300))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            // 卡片背面根據 Theme 的設定改變顏色
            shape.fill(themeColor)
                 .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.ismatched && !card.isFaceUp ? 0 : 1)
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
}
