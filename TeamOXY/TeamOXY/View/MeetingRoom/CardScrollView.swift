//
//  CardScrollView.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/07/10.
//

import SwiftUI

struct CardScrollView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(Topic.topicViews) { topic in
                    Image(topic.topic.topicImageLabel)
                        .resizable()
                        .frame(width: UIScreen.screenWidth * 0.285, height: UIScreen.screenWidth * 0.285 * 1.4)
                }
            }
        }
    }
}

struct CardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CardScrollView()
    }
}
