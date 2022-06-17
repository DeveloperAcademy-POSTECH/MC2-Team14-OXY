//
//  AnonymousLoginLoadingView.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/17.
//

import SwiftUI

struct AnonymousLoginLoadingView: View {
    var body: some View {
        LottieView(filename: "MC2_Lotti")
            .frame(width: UIScreen.screenWidth * 1.369, height: UIScreen.screenWidth * 1.369)
    }
}

struct AnonymousLoginLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        AnonymousLoginLoadingView()
    }
}
