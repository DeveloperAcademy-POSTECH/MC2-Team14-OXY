//
//  testCarousel.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/07/10.
//

import SwiftUI

struct testCarousel: View {
    
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    @ObservedObject var viewModel = CarouselViewModel()
    
    var body: some View {
        
        ZStack {
            ForEach(viewModel.topicViews) { topic in
                ZStack {
                    let _ = print("나는 가로길이 \(CarouselViewConstants.smallCardWidth)")
                    Image(topic.topic.topicImageLabel)
                        .resizable()
                        .frame(width: CarouselViewConstants.smallCardWidth * 1.08, height: CarouselViewConstants.smallCardHeight * 1.08)
                }
                .offset(x: myXOffset(topic.currentCardIndex), y: 0)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width
                }
                .onEnded { value in
                    withAnimation(.interactiveSpring()) {
                        print(draggingItem)
                        draggingItem = snappedItem + value.predictedEndTranslation.width
                        if draggingItem <= -(UIScreen.screenWidth * 0.33) {
                            draggingItem = -(UIScreen.screenWidth * 0.33)
                        } else if draggingItem >= (UIScreen.screenWidth * 0.5) {
                            draggingItem = (UIScreen.screenWidth * 0.33)
                        } else {
                            draggingItem = snappedItem + value.predictedEndTranslation.width
                        }
                        snappedItem = draggingItem
                        print(UIScreen.screenWidth * 0.48)
                    }
                }
        )
    }

    func myXOffset(_ item: Int) -> Double {
        return Double(item - 2) * CarouselViewConstants.smallCardWidth * 1.18 + draggingItem
        }
}

struct testCarousel_Previews: PreviewProvider {
    static var previews: some View {
        testCarousel()
    }
}
