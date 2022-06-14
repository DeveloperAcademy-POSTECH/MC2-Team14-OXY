//
//  QRCodeView.swift
//  TeamOXY
//
//  Created by 정재윤 on 2022/06/11.
//

import SwiftUI

struct QRCodeView: View {
    let url: String
    
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
            
            Spacer()
            
            QRCode(url: url)
                .padding(.bottom)
            
            HStack {
                Text("팀원들에게")
                Text("QR코드")
                    .foregroundColor(.PrimaryBlue)
                Text("를 공유해주세요.")
            }
            .headLine4()
             
            Spacer()
            Spacer()
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView(url: "")
    }
}
