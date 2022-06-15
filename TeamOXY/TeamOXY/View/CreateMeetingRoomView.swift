//
//  CreateMeetingRoomView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI

struct CreateMeetingRoomView: View {
    @ObservedObject var vm: MeetingRoomViewModel

    let barTitle: String

    @State private var text = ""
    @State private var textField = generateRandomNickname()
    @State private var isCreated = false
    
    @Binding var backToHome: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("우리 그룹의 방 이름은 무엇인가요?")
                    .body1()
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    
                HStack {
                    TextField("\(textField) 방", text: $text)
                        .fields()
                    
                    if text != "" {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color(uiColor: .systemGray3))
                            .padding(4)
                            .onTapGesture {
                                withAnimation {
                                    self.text = ""
                                }
                            }
                    }
                }
                .padding()
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                .background(Color(.systemGray6))
                .cornerRadius(55)
            }
            
            Spacer()
            
            RoundButton(buttonType: .primary, title: "시작하기", isButton: true, didCompletion: {
                if text.isEmpty {
                    vm.roomId = "\(textField) 방"
                } else {
                    vm.roomId = text
                }
                
                vm.anonymousLogin(scannedCodeUrl: nil, nickname: vm.roomId)
                
                backToHome = true
                isCreated.toggle()
            })
            .padding(.bottom)
            .background(NavigationLink(isActive: $isCreated) {
                MeetingRoomView(vm: vm, scannedCodeUrl: nil, backToHome: $backToHome)
            } label: { }.hidden())
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}
