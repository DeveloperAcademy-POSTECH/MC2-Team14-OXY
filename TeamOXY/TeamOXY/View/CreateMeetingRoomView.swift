//
//  CreateMeetingRoomView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI

struct CreateMeetingRoomView: View {
    let barTitle: String
    
    @ObservedObject private var vm = MeetingRoomViewModel()
    
    @State private var text = ""
    @State private var isCreated = false
    
    @Binding var backToHome: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("우리 그룹의 방 이름은 무엇인가요?")
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    
                HStack {
                    TextField("\(generateRandomNickname()) 방", text: $text)
                    
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
            .font(.custom("Pretendard-Medium", size: 16))
            
            Spacer()
            
            NavigationLink(isActive: $isCreated) {
                MeetingRoomView(scannedCodeUrl: nil, backToHome: $backToHome)
            } label: {
                RoundButton(buttonType: .primary, title: "시작하기", isButton: true, didCompletion: {
                    if text.isEmpty {
                        text = generateRandomNickname()
                        vm.roomTitle = text + " 방"
                    } else {
                        vm.roomTitle = text
                    }
                    
                    isCreated.toggle()
                })
                    .font(.custom("Pretendard-Black", size: 16))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                    .background(Color.PrimaryBlue)
                    .clipShape(Capsule())
            }
            .padding(.bottom)
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateMeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMeetingRoomView(barTitle: "방 만들기", backToHome: .constant(true))
    }
}
