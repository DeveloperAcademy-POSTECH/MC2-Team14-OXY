//
//  TempCardView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct TempCardView: View {
    var body: some View {
        ZStack {
            Color(.green)
            VStack {
                Text("Card").font(.system(size: 30)).bold()
            }
        }
        .frame(width: 100, height: 150, alignment: .center)
    }
}

struct TempCardView_Previews: PreviewProvider {
    static var previews: some View {
        TempCardView()
    }
}
