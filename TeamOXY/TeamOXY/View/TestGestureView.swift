//
//  TestGestureView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct TestGestureView: View {
    var body: some View {
        ZStack {
            VStack {
                CardZoneView()
                Spacer()
                CardDeckView()
            }
            TestCardView()
        }
        .ignoresSafeArea()
    }
}

struct TestGestureView_Previews: PreviewProvider {
    static var previews: some View {
        TestGestureView()
    }
}
