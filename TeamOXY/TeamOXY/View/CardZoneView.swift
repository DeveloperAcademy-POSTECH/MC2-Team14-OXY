//
//  CardZoneView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct CardZoneView: View {
    let cardWidth = 250
    let cardZoneHeight = 500
    let cardPaddingTop = 125
    
    var body: some View {
        ZStack {
            // 전체 크기 500
            Rectangle()
                .stroke(.black)
                .overlay(Text("카드 놔둘 공간"))
                .frame(width: 250, height: 375, alignment: .center)
                .padding(.top, 125)
        }
    }
}

struct CardZoneView_Previews: PreviewProvider {
    static var previews: some View {
        CardZoneView()
    }
}
