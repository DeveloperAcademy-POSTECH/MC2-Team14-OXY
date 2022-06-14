//
//  QRCodeView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI

struct QRCodeView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .foregroundColor(.black)
            }
            .padding()
            
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
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
