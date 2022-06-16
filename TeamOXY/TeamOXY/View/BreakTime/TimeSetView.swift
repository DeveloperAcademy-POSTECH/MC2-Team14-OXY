//
//  TimeSetView.swift
//  TeamOXY
//
//  Created by yeekim on 2022/06/10.
//

import SwiftUI

struct TimeSetView: View {
    @ObservedObject var viewModel = CompletionViewModel()
    
    // time picker
    private let data: [[String]] = [
        Array(5...30).map{"\($0)"},
        Array(0...59).map{"\($0)"}
    ]
    
    //기본 쉬는 시간 : 10분
    @State private var selections: [Int] = [5, 2]
    @State private var selected = 5
    
    
    var minute = Array(5...30).map{"\($0)"}
        
    var second = Array(0...59).map{"\($0)"}
    
    @State var selectedMinute = "5"
    @State var selectedSecond = "0"
    
    var body: some View {
        
        VStack {
            ZStack {
                Text("쉬는 시간을 설정해주세요.")
                    .headLine4()
                    .foregroundColor(.DarkGray1)
                    .offset(y:-230)

                ZStack {
                    // blue box
                    RoundedRectangle(cornerRadius: 17)

                        .frame(width: UIScreen.main.bounds.size.width - 50, height: 34)
                        .foregroundColor (.PrimaryBlue)

                    // Time Picker

                    HStack {
                        
                        Spacer()
                        Picker("", selection: $selectedMinute) {
                            ForEach(minute, id: \.self) {
                                Text($0)
                                    .fontWeight(.bold)
                                    .foregroundColor( $0 == selectedMinute ? .white : .black)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 60)
                        .clipped()
                        
                        Text("분")
                            .font(.custom("Pretendard-Bold", size: 20))
                            .padding(.trailing, 30)
                        
                        Spacer(minLength: 60)
                        
                        
                        Picker("", selection: $selectedSecond) {
                            ForEach(second, id: \.self) {
                                Text($0)
                                    .fontWeight(.bold)
                                    .foregroundColor( $0 == selectedSecond ? .white : .black)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 60)
                        .clipped()
                        
                        Text("초")
                            .font(.custom("Pretendard-Bold", size: 20))
                        
                        Spacer()
                    }
                    .foregroundColor(.white)
                }

                VStack {
                    Spacer()
                    NavigationLink(destination: BreakTimeView(counter: 0, countTo: (Int(data[0][selections[0]]) ?? 10) * 60 + (Int(data[1][selections[1]]) ?? 0))) {
                        RoundButton(buttonType: .primary, title: "쉬는시간 시작", isButton: false, didCompletion: nil)
                    }
                }
            }
        }
        .navigationBarTitle("쉬는시간 설정", displayMode: .inline)
        .onAppear{
            // FinishTopicView뜨는 조건 초기화
            viewModel.FinishTopicViewCondition = [false, true, false]
        }
    }
}

struct TimeSetView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSetView()
    }
}
