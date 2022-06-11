////
////  TestView.swift
////  TeamOXY
////
////  Created by ParkJunHyuk on 2022/06/10.
////
//
//import SwiftUI
//
//struct TestView: View {
//
//    let emojis = ["🤔","👎","👍","🤩","🫠","🔥","❤️","😱","🤭","🥱","👀","✅","🙅","🎉","😂"]
//
//    @State private var counter = 1
//    @State private var emojiString = ""
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false){
//            HStack {
//                ForEach(emojis, id: \.self) { emoji in
//                    ZStack(alignment: .center) {
//
//                        Circle()
//                            .foregroundColor(.white)
//                            .shadow(color: .gray.opacity(0.5), radius: 15, x: 3, y: 3)
//
//                        Button(action: {
//
//                            counter += 1
//                            emojiString = emoji
//                            print(emojiString)
//                            print(counter)
//
////                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
////                                            counter = 0
////                                        }
//
////                                        counter = 0
//
//                        }){
//                            Text(emoji)
//                                .font(.system(size: 35))
//                                .padding(8)
//                        }
//                    }
//                        .padding(4)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
//
//// Global Function for getting Size...
//func getRect() -> CGRect {
//    return UIScreen.main.bounds
//}
//
//// Emit Particle View...
//// AKA CAEmmiterLayer form UIkit...
//
//struct EmitterView: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> some UIView {
//        let view = UIView()
//        view.backgroundColor = .clear
//
//        // Emitter Layer..
//        let emitterLayer = CAEmitterLayer()
//        emitterLayer.emitterShape = .line
//        emitterLayer.emitterCells = createEmiterCells()
//
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        <#code#>
//    }
//
//    func createEmiterCells() -> [CAEmitterCell] {
//        let cell = CAEmitterCell()
//
//        cell
//
//        return [cell]
//    }
//}
//
//
