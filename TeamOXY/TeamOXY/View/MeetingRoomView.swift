//
//  MeetingRoomView.swift
//  TeamOXY
//
//  Created by 최동권 on 2022/06/10.
//

import SwiftUI

struct MeetingRoomView: View {
    var body: some View {
        ZStack{
            // zstack으로 가운데에서 튀어나오기 때문에 딱 5개일 때 인터렉션이 어색하고, 6개 이상부터 자연스러움
            CarouselView(itemHeight: 150, views: [
                Image("Card1"),
                Image("Card2"),
                Image("Card3"),
                Image("Card4"),
                Image("Card5"),
                Image("Card6"),
        ])
        }
        
    }
}


struct MeetingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingRoomView()
    }
}
