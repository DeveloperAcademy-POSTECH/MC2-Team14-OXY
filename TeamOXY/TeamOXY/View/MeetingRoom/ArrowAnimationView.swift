//
//  Arrows.swift
//  TeamOXY
//
//  Created by ParkJunHyuk on 2022/06/12.
//

import SwiftUI

struct ArrowShape : Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height/2.0))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        
        

        return path
    }
}

struct ArrowAnimationView: View {
    private let arrowCount = 3

    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    @State var scale:CGFloat = 1.0
    @State var fade:Double = 0.5

    var body: some View {

        ZStack {
            HStack{
                ForEach(0 ..< arrowCount, id: \.self) { i in
                    ArrowShape()
                        .stroke(style: StrokeStyle(lineWidth: CGFloat(5),
                                                  lineCap: .round,
                                                  lineJoin: .round ))
                        .foregroundColor(Color.black.opacity(0.5))
                        .aspectRatio(CGSize(width: 20, height: 70), contentMode: .fit)
                        .frame(width: 10, height: 70)
                        .animation(nil)
                        .opacity(self.fade)
                        .scaleEffect(self.scale)
                        .animation(
                            Animation.easeOut(duration: 0.5)
                            //.repeatForever(autoreverses: true)
                            .repeatCount(1, autoreverses: true)
                            .delay(0.2 * Double(i))
                        )
                }.onReceive(self.timer) { _ in
                     self.scale = self.scale > 1 ?  1 : 1.2
                     self.fade = self.fade > 0.5 ? 0.5 : 1.0
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.scale = 1
                                self.fade = 0.5
                            }
                    }
            }
        }
    }
}
