//
//  CreateMeetingRoomView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI

struct CreateMeetingRoomView: View {
    @AppStorage("roomId") var roomId: String!
    
    @ObservedObject var vm: RoomViewModel
    
    @State private var text = ""
    @State private var textField = generateRandomNickname()
    
    @Binding var backToHome: Bool
    
    let barTitle: String
    
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
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    
                }
            })
            .padding(.bottom)
        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        
        NavigationLink {
            MeetingRoomView(vm: vm, backToHome: $backToHome, roomTitle: text)
        } label: { }.hidden()
    }
}
