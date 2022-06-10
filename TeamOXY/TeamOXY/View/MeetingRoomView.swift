//
//  MeetingRoomView.swift
//  TeamOXY
//
//  Created by Minkyeong Ko on 2022/06/10.
//

import SwiftUI

struct MeetingRoomView: View {
    @State private var showingLeaveRoomSheet: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .confirmationDialog("방을 정말 떠나시겠습니까? \n 방에 다시 입장하려면 팀원들의 QR코드를 통해 입장해주세요",
                                isPresented: $showingLeaveRoomSheet,
                                titleVisibility: .visible) {
                Button("떠나기") {
                    print("떠나기")
                }
                Button("취소", role: .cancel) {
                }
            }
            .navigationTitle("익명의 원숭이 방 6")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showingLeaveRoomSheet.toggle()
                    }) {
                        Image("Button_LeaveRoom")
                            .imageScale(.large)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                            .imageScale(.large)
                    }
                }
                
            })
        }
    }
}

struct MeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomView()
    }
}