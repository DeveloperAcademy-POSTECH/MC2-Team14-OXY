//
//  TimeSetView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct TimeSetView: View {
    @ObservedObject var viewModel = CompletionViewModel()
    
    // time picker data min:5분 ~ max: 30분 59초
    var minutes = [Int](5...30)
    var seconds = [Int](0..<60)
    
    //기본 쉬는 시간 : 10분 설정을 위한 인덱스 값
    @State var minuteSeletion = 5
    @State var secondSeletion = 0
    
    var body: some View {
        VStack {
            ZStack {
                Text("쉬는 시간을 설정해주세요.")
                    .headLine4()
                    .foregroundColor(.DarkGray1)
                    .offset(y:-230)
                // Time Picker
                ZStack {
                    // selected items
                    RoundedRectangle(cornerRadius: 17)
                        .frame(width: UIScreen.main.bounds.size.width-140, height: 34)
                        .foregroundColor (.PrimaryBlue)
                    Text("            분                     초")
                        .font(.custom("Pretendard-Bold", size: 20))
                        .foregroundColor(.white)
                
                    GeometryReader { geometry in
                        HStack {
                            Spacer()
                            Spacer()
                            Picker(selection: self.$minuteSeletion, label: Text("")) {
                                ForEach(0 ..< self.minutes.count) { index in
                                    Text("\(self.minutes[index])").tag(index)
                                        .font(.custom("Pretendard-Bold", size: 20))
                                        .foregroundColor(index == minuteSeletion ? .white : .gray)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: geometry.size.width/6, height: geometry.size.height, alignment: .center)
                            .clipped()
                            Spacer()
                            Picker(selection: self.$secondSeletion, label: Text("")) {
                                ForEach(0 ..< self.seconds.count) { index in
                                    Text("\(self.seconds[index])").tag(index)
                                        .font(.custom("Pretendard-Bold", size: 20))
                                        .foregroundColor(index == secondSeletion ? .white : .gray)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: geometry.size.width/6, height: geometry.size.height, alignment: .center)
                            .clipped()
                            Spacer()
                            Spacer()
                        }
                    }
                }
                VStack {
                    Spacer()
                    NavigationLink(destination: BreakTimeView(counter: 0, countTo: (Int(minutes[minuteSeletion])) * 60 + (Int(seconds[secondSeletion])))) {
                        RoundButton(buttonType: .primary, title: "쉬는시간 시작", isButton: false, didCompletion: nil)
                    }
                }
            }
        }
        .navigationBarTitle("쉬는시간 설정", displayMode: .inline)
    }
}

struct TimeSetView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSetView()
    }
}
