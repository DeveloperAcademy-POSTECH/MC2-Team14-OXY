//
//  CreateMeetingRoomView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI

struct CreateMeetingRoomView: View {
    let barTitle: String
    
    @State private var text = ""
    
    @FocusState private var focusedField: FieldType?
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("우리 그룹의 방 이름은 무엇인가요?")
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .roomTitle)
                    
                HStack {
                    TextField("익명의 원숭이 방", text: $text)
                    
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
            
            NavigationLink {
                MeetingRoomView()
            } label: {
                RoundButton(buttonType: .primary, title: "시작하기", isButton: false, didCompletion: nil)
                    .font(.custom("Pretendard-Black", size: 16))
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 55)
                    .background(Color.PrimaryBlue)
                    .clipShape(Capsule())
            }

        }
        .navigationTitle(barTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedField = .roomTitle
            }
        }
    }
}

struct CreateMeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMeetingRoomView(barTitle: "방 만들기")
    }
}
