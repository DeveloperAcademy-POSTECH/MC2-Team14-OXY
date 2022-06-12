//
//  QRCodeView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI

struct QRCodeView: View {
    var body: some View {
        VStack {
            QRCode(url: "www.naver.com")
                .padding(.bottom)
            
            HStack {
                Text("팀원들에게")
                Text("QR코드")
                    .foregroundColor(.PrimaryBlue)
                    .font(.custom("Pretendard-Black", size: 18))
                Text("를 공유해주세요.")
            }
            .font(.custom("Pretendard-Bold", size: 18))
             
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "xmark")
            }
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QRCodeView()
        }
    }
}
