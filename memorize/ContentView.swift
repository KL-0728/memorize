//
//  ContentView.swift
//  memorize
//
//  Created by 11344113 on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    //var emojis=["A","B","C","D"]
    var emojis:Array<String>=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    @State var emojicount=20
    var body: some View {
        VStack{
            cardList
            Spacer()
            actionButtons
        }
        .padding()
        .foregroundStyle(.yellow)
    }
    var cardList: some View{
        ScrollView{
            LazyVGrid(columns:[GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0){
                ForEach(emojis[0..<emojicount],id:\.self){emoji in CardView(content: emoji)
                        .aspectRatio(2/3,contentMode: .fit)
                }
            }
        }
    }
    var actionButtons: some View{
        HStack{
            remove
            Spacer()
            add
        }
        .font(.largeTitle)
    }
    var add: some View{
        Button{
            if emojicount<emojis.count{
                emojicount+=1
            }
        }
               label: {
                   Image(systemName: "plus.circle")
        }
    }
    
    var remove: some View{
        Button{
            if emojicount>1{
                emojicount-=1
            }
        }
               label: {
                   Image(systemName: "minus.circle")
        }
    }
}
struct CardView: View {
    @State var isFaceUp: Bool=true
    var content: String
    var body: some View {
        ZStack{
            let shape=RoundedRectangle(cornerRadius: 20)
            Group
            {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(Font.system(size: 300))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1,contentMode: .fit)
            }
            .opacity(isFaceUp ? 1:0)
            shape.opacity(isFaceUp ? 0:1)
        }
        .onTapGesture (perform:{
            isFaceUp = !isFaceUp
        })
    }
}

#Preview {
    ContentView()
}
