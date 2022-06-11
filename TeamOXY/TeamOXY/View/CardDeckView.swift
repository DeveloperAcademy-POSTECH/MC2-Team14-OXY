//
//  CardDeckView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct CardDeckView: View {
    var body: some View {
        Rectangle()
            .fill(.gray)
            .overlay(Text("카드 있는 공간"))
            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
    }
}

struct CardDeckView_Previews: PreviewProvider {
    static var previews: some View {
        CardDeckView()
    }
}
