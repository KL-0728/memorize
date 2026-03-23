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
    @State var emojicount=6
    var body: some View {
        VStack{
            HStack{
                ForEach(emojis[0..<emojicount],id:\.self){emoji in CardView(content: emoji)}
            }
            HStack{
                Button(action:{emojicount-=1},label:{Text("Remove Card")})
                Spacer()
                Button(action:{emojicount+=1},label:{Text("Add Card")})
            }
        }
        .padding()
        .foregroundStyle(.yellow)
    }
}
struct CardView: View {
    @State var isFaceUp: Bool=true
    var content: String
    var body: some View {
        ZStack{
            let shape=RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                RoundedRectangle(cornerRadius: 20)
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            }
            else{
                shape
            }
            }
        .onTapGesture(perform: {
            isFaceUp = !isFaceUp
        })
        }
    }

#Preview {
    ContentView()
}
