//
//  ContentView.swift
//  memorize
//
//  Created by 11344113 on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFaceUp: false)
            CardView()
            CardView()
        }
        .padding()
        .foregroundStyle(.yellow)
    }
}
struct CardView: View {
    var isFaceUp: Bool=true
    var body: some View {
        ZStack{
            if isFaceUp{
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(lineWidth: 3)
                Text("bochen is gay")
            }
            else{
                RoundedRectangle(cornerRadius: 20)
            }
            }
        }
    }

#Preview {
    ContentView()
}
