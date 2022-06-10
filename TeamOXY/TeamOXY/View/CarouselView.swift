//
//  CarouselView.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/06/10.
//

import SwiftUI

struct CarouselView: View {
    // drag를 어느정도 했는지 알 수 있는 프로퍼티
    @GestureState private var dragState = DragState.inactive
    @State var carouselLocation = 0
    
    @State var degree = 0.0
    
    var itemHeight: CGFloat
    var views: [Image]
    
    var spacerWidth: CGFloat = UIScreen.main.bounds.width / 4.1
    private func onDragEnded(drag: DragGesture.Value) {
        
        let dragThreshold:CGFloat = 100
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold{
            carouselLocation =  carouselLocation - 1
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold)
        {
            carouselLocation =  carouselLocation + 1
        }
    }
    
    var body: some View {
        ZStack{
            //                        VStack{
            //                            Text("\(dragState.translation.width)")
            //                            Text("Carousel Location = \(carouselLocation)")
            //                            Text("Relative Location = \(relativeLoc())")
            //                            Text("\(relativeLoc()) / \(views.count-1)")
            //                            Spacer()
            //                        }
            VStack{
                
                ZStack{
                    
                    // 각각의 요소에 그림자 넣는 법 말고 전체를 묶어서 그림자를 넣는 법 고민해보기
                    
                    ForEach(0..<views.count){ i in
                        VStack{
                            Spacer()
                            self.views[i]
                                .resizable()
                                .frame(width: getWidth(i), height: getWidth(i) * 1.4)
                                .aspectRatio(contentMode: .fit)
                                .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                                .background(Color.white)
                                .cornerRadius(5)
                            //                                .border(.black, width: 1)
                                .shadow(color: .gray.opacity(0.5), radius: shadowSetting(i)[0], x: shadowSetting(i)[1], y: shadowSetting(i)[2])
                                .opacity(self.getOpacity(i))
                                .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                            // offset y를 longpress가 눌리면, 다니 함수의 y값으로 return 하도록 삼항연산자(?)
                                .offset(x: self.getOffsetX(i), y: self.getOffsetY(i))
                                .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
                            // animation은 그 바로 위에 있는 메소드에 적용하는 것, 즉 animation이 3번 반복되는이유는
                            // frame, shadow, offset변화에 애니메이션을 주기 위함
                            Spacer()
                        }
                        .zIndex(zindex(i))
                    }
                    
                }
                .simultaneousGesture(
                    DragGesture()
                        .updating($dragState) { drag, state, transaction in
                            state = .dragging(translation: drag.translation)
                        }
                        .onEnded(onDragEnded)
                        .exclusively(before: RotationGesture()
                            .onChanged({ angle in
                                self.degree = angle.degrees
                            }))
                )
                Spacer()
            }
        }
    }
    
    // 그림자 세팅
    func shadowSetting(_ i: Int) -> [CGFloat] {
        if i == relativeLoc() {
            return [40,3,24]
        } else {
            return [20,3,24]
        }
    }
    
    // 센터의 background color 변경
    func centerColor(_ i: Int) -> Color {
        if i == relativeLoc() {
            return Color.white
        } else {
            return Color.gray.opacity(0.3)
        }
    }
    
    // 센터의 zindex 변경
    func zindex(_ i: Int) -> Double {
        if i == relativeLoc() {
            return 2
        } else if i + 1 == relativeLoc()
                    || i - 1 == relativeLoc(){
            return 1
        } else {
            return 0
        }
    }
    
    // 상대적 위치
    func relativeLoc() -> Int{
        // % : 나머지 연산
        // views.count * 10000 을 넣은 이유는 carousellLocation이 음수가 되는 상황을 막기 위한 것
        return ((views.count * 10000) + carouselLocation) % views.count
    }
    
    // width 설정
    func getWidth(_ i: Int) -> CGFloat {
        if i == relativeLoc(){
            return UIScreen.main.bounds.width / 3.5
        } else {
            return UIScreen.main.bounds.width / 4.1
        }
    }
    
    //    // height
    //    func getHeight(_ i:Int) -> CGFloat{
    //        if i == relativeLoc(){
    //            return itemHeight + 10
    //        } else {
    //            return itemHeight - 30
    //        }
    //    }
    
    func getOpacity(_ i:Int) -> Double{
        
        if i == relativeLoc()
            || i + 1 == relativeLoc()
            || i - 1 == relativeLoc()
            || i + 2 == relativeLoc()
            || i - 2 == relativeLoc()
            || (i + 1) - views.count == relativeLoc()
            || (i - 1) + views.count == relativeLoc()
            || (i + 2) - views.count == relativeLoc()
            || (i - 2) + views.count == relativeLoc()
        {
            return 1
        } else {
            return 0
        }
    }
    
    func getOffsetY(_ i: Int) -> CGFloat {
        if i == relativeLoc() {
            return -8
        } else {
            return 0
        }
    }
    
    func getOffsetX(_ i:Int) -> CGFloat{
        
        //This sets up the central offset
        if (i) == relativeLoc()
        {
            //Set offset of cental
            //dragState.translation.width는 드래그하는 순간 움직인 거리의 width를 더해줌으로써 움직이는 것처럼 보이게 하기 위함
            return self.dragState.translation.width
        }
        //These set up the offset +/- 1
        else if
            (i) == relativeLoc() + 1
                ||
                (relativeLoc() == views.count - 1 && i == 0)
        {
            //Set offset +1
            return self.dragState.translation.width + (100)
        }
        else if
            (i) == relativeLoc() - 1
                ||
                (relativeLoc() == 0 && (i) == views.count - 1)
        {
            //Set offset -1
            return self.dragState.translation.width - (100)
        }
        //These set up the offset +/- 2
        else if
            (i) == relativeLoc() + 2
                ||
                (relativeLoc() == views.count-1 && i == 1)
                ||
                (relativeLoc() == views.count-2 && i == 0)
        {
            return self.dragState.translation.width + (2*(100))
        }
        else if
            (i) == relativeLoc() - 2
                ||
                (relativeLoc() == 1 && i == views.count-1)
                ||
                (relativeLoc() == 0 && i == views.count-2)
        {
            //Set offset -2
            return self.dragState.translation.width - (2*(100))
        }
        //These set up the offset +/- 3
        else if
            (i) == relativeLoc() + 3
                ||
                (relativeLoc() == views.count-1 && i == 2)
                ||
                (relativeLoc() == views.count-2 && i == 1)
                ||
                (relativeLoc() == views.count-3 && i == 0)
        {
            return self.dragState.translation.width + (3*(100))
        }
        else if
            (i) == relativeLoc() - 3
                ||
                (relativeLoc() == 2 && i == views.count-1)
                ||
                (relativeLoc() == 1 && i == views.count-2)
                ||
                (relativeLoc() == 0 && i == views.count-3)
        {
            //Set offset -2
            return self.dragState.translation.width - (3*(100))
        }
        //This is the remainder
        else {
            return 10000
        }
    }
    
    
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

//
//struct CarouselView_Previews: PreviewProvider {
//    static var previews: some View {
//        CarouselView()
//    }
//}
