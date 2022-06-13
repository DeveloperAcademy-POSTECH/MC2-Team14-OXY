//
//  TopicCompletionView.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/12.
//

import SwiftUI

struct CompletedTopicView: View {
    var body: some View {
        VStack {
            LottieView(filename: "Utils/Lottie/Completion")
                .frame(width: 300, height: 300)
        }
    }
}

struct CompletedTopicView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedTopicView()
    }
}
